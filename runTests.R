library(magrittr)
library(testthat)
library(injectoR)


testthat::test_dir(
  path = "tests",
  reporter = "summary")
