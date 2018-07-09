
testthat::test_that("Detect SQLi attack", {
  sqliArgument <- "%' or 0=0#"
  attackResults <- injectoR::detectAttack(
    argument = sqliArgument)
  
  testthat::expect_equal(attackResults$isSQLi, 1)
  testthat::expect_equal(attackResults$isXSS, 0)
})


testthat::test_that("Detect XSS attack", {
  xssArgument <- "<script>alert('hello')</script>"
  attackResults <- injectoR::detectAttack(
    argument = xssArgument)
  
  testthat::expect_equal(attackResults$isSQLi, 0)
  testthat::expect_equal(attackResults$isXSS, 1)
})


testthat::test_that("Detect XSS attack", {
  xssRequestURI <- 'http://mysite.com/pictures/search.php?query=<script src="http://malicious.com/evil.js"></script>'
  attackResults <- injectoR::detectAttack(
    argument = xssRequestURI)
  
  testthat::expect_equal(attackResults$isSQLi, 0)
  testthat::expect_equal(attackResults$isXSS, 1)
})
