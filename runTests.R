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


detectors <- c("libinjection_sqli", "libinjection_xss")
for (detector in detectors) {
  paste0("src/", detector) %>% 
    dyn.load()
}

testthat::test_dir(
  path = "tests",
  reporter = "summary")
