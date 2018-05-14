# Test for the farsForCoursera package.

library(testthat)

expect_that(make_filename(2013), equals("accident_2013.csv.bz2"))

expect_that(fars_read("false_file.txt"), throws_error())

