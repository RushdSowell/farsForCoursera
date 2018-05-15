#'  Creating a dataframe table from a csv file.
#'
#'  This is a function that first check if the file name inserted exist.
#'  If it did not, an error is produced ("<filename> does not exist").
#'  If it did exist the file is read, and the data is transformed
#'  into a table of data frame.
#'
#' @param filename A string that gives the filename of the file that we wish to read.
#'
#' @return A data frame table is returned.
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @examples
#' fars_read("accident_2013.csv")
#' fars_read("C:/Users/learn/Documents/R lesson/accident_2013.csv")
#'
#' @export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}


#'  Create a string 'accident_<specified year>.csv.bz2'
#'
#'  By inserting the intended year,
#'  the function will create a string 'accident_<specified year>.csv.bz2',
#'  that can be used as a reference to a file name in other functions.
#'
#' @param year An integer that represents the year we want to put in the string.
#'
#' @return A string 'accident_<specified year>.csv.bz2'
#'
#' @examples
#' make_filename(2017)
#' make_filename(2015)
#'
#' @export
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}

#'  Year and month the accidents happened.
#'
#'  The function takes the list of years that we want to know about the accident,
#'  find the files that record those accidents by the year
#'  and returning the columns of the months and the year.
#'  An error "invalid year: <inputed year>" will be printed
#'  if the data of the year we inputed is not availabe.
#'
#' @param years A list of years (in integer) that we want to read the data about.
#'
#' @return A data frame with 2 columns specifying the Month and the year for each accidents
#'    by the years that we put in the list.
#'
#' @importFrom dplyr mutate select
#' @importFrom magrittr "%>%"
#'
#' @examples
#' fars_read_years(c(2013, 2014))
#' fars_read_years(2013)
#'
#' @export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}

#'  Giving a summary of the accidents that happens by the years and months
#'
#'  By giving a list of years that we want to know about the road accidents that happened,
#'  the function will return a summary of the numbers of accidents that happened,
#'  grouped by the years and months.
#'
#' @param years A list of integers, specifying the year that we want to have the summary
#'     of road accidents
#'
#' @return A table grouped by the year and the 12 months, giving the number of road
#'     accidents that happened.
#'
#' @importFrom dplyr bind_rows group_by summarize
#' @importFrom tidyr spread
#' @importFrom magrittr "%>%"
#'
#' @examples
#'  fars_summarize_years(c(2013, 2014, 2015))
#'  fars_summarize_years(2015)
#'
#' @export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}

#'  Pinpointing on a map where accident happened in a year
#'
#'  The function will show us the location on a state map, of where accidents happened
#'  by the year that we want.
#'  If an invalid State Number is inputed an error message will be given.
#'  An error message will also appears if there is no accidents happened in the year
#'  at the State.
#'
#' @param state.num refer to the State Number that we want to plot the accident.
#' @param year The year we want to plot the occurence of accidents on the State maps
#'      specified by the state.num parameter.
#'
#' @return A map of the state inputed through the state.num parameter with accidents location
#'      marked on the map for the desired year.
#'
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @examples
#' # Setting the path for the example data
#' expath <- system.file("extdata", package="farsForCoursera")
#' setwd(expath)
#' fars_map_state(1, 2013)
#' fars_map_state(3, 2015).
#'
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
