library(magrittr)
library(testthat)
library(injectoR)


results <- testthat::test_dir(
  path = "testthat",
  reporter = "summary")

