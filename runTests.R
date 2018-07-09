library(magrittr)
library(testthat)


loadFunctions <- "R/" %>% 
  paste0(list.files(
    path = "R",
    pattern = "*.R",
    recursive = TRUE)) %>%
  sapply(
    FUN = source,
    .GlobalEnv)

testthat::test_dir(
  path = "tests",
  reporter = "summary")
