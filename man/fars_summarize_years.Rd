% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{fars_summarize_years}
\alias{fars_summarize_years}
\title{Giving a summary of the accidents that happens by the years and months}
\usage{
fars_summarize_years(years)
}
\arguments{
\item{years}{A list of integers, specifying the year that we want to have the summary
of road accidents}
}
\value{
A table grouped by the year and the 12 months, giving the number of road
    accidents that happened.
}
\description{
By giving a list of years that we want to know about the road accidents that happened,
 the function will return a summary of the numbers of accidents that happened,
 grouped by the years and months.
}
\examples{
fars_summarize_years(c(2013, 2014, 2015))
fars_summarize_years(2015)

}
