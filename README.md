# farsForCoursera
A project for a Coursera course, for functions using the Fatal Accident Reporting System, of the US National Highway Traffic Safety Administration 

Among the functions that are included in this package, they have the following output:
```
* A table, grouping the accident that happens by year and months.

* A map pinpointing the location where the accidents happened in a year, according to the state required.
```

Base on the requirement of the course, this package has pass the Travis build test, which can be viewed as of the following:
[![Build Status](https://travis-ci.org/RushdSowell/farsForCoursera.svg?branch=master)](https://travis-ci.org/RushdSowell/farsForCoursera)

## The Data

The data are according to years, with the following columns:

`STATE,ST_CASE,VE_TOTAL,VE_FORMS,PVH_INVL,PEDS,PERNOTMVIT,PERMVIT,PERSONS,COUNTY,CITY,DAY,MONTH,YEAR,DAY_WEEK,HOUR,MINUTE,NHS,ROAD_FNC,ROUTE,TWAY_ID,TWAY_ID2,MILEPT,LATITUDE,LONGITUD,SP_JUR,HARM_EV,MAN_COLL,RELJCT1,RELJCT2,TYP_INT,WRK_ZONE,REL_ROAD,LGT_COND,WEATHER1,WEATHER2,WEATHER,SCH_BUS,RAIL,NOT_HOUR,NOT_MIN,ARR_HOUR,ARR_MIN,HOSP_HR,HOSP_MN,CF1,CF2,CF3,FATALS,DRUNK_DR`

The data can be taken from ftp://ftp.nhtsa.dot.gov/fars/
Choose the required year, from there chose national directory, download the zipped file for CSV format. In the zip file take the accident.csv file. This is the required file, change the name of the file as shown below, and compressed it in the bz2 format.

With this package, some data are provided for fatal road accidents for the year 2013, 2014 and 2015.

The data filename are in the following format: "accident_year.csv.bz2", where "year" is the year the data refer to. 
The example data can be located at `system.file("extdata", "accident_year.csv.bz2", package = "farsForCoursera")`, where again, the 'year' in the file name can be replaced with 2013, 2014, or 2015.

For example, to read data from the year 2015, the file will be "accident_2015.csv.bz2".

## fars_summarize_years function.

This function will provide a summary of fatal road accidents. The data will be presented by the years a user provided and this will show the numbers of fatal accidents that occured by months.


We can input a year,
```
fars_summarize_years(2013)

```

or a collection of years for comparison.

```
fars_summarize_years(c(2013,2014,2015))

```

## fars_map_state

This function gives as output a plot of the location of fatal accidents on a map of a state as inputed.

The input for the function is a state number and a year. 
Given these 2 inputs, a map of the state with the location of the fatal accidents will be plotted.

For example if we want to see the map plotted for the state Arizona (01) for the year 2013 :
```
fars_map_state(1, 2013)

```
