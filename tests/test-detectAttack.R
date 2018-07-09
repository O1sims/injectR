
testthat::test_that("Detect SQLi attack", {
  attackResults <- "%' or 0=0#" %>%
    detectAttack()
  
  testthat::expect_equal(attackResults$isSQLi, 1)
  testthat::expect_equal(attackResults$isXSS, 0)
})


testthat::test_that("Detect XSS attack", {
  attackResults <- "<script>alert('hello')</script>" %>%
    detectAttack()
  
  testthat::expect_equal(attackResults$isSQLi, 0)
  testthat::expect_equal(attackResults$isXSS, 1)
})


testthat::test_that("Detect XSS attack", {
  attackResults <- 'http://mysite.com/pictures/search.php?query=<script src="http://malicious.com/evil.js"></script>' %>%
    detectAttack()
  
  testthat::expect_equal(attackResults$isSQLi, 0)
  testthat::expect_equal(attackResults$isXSS, 1)
})
