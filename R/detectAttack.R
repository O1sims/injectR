#' @title Detect Attack
#'
#' @description This function takes in an argument and analyses it for malicious strings. 
#'  If malicious strings are found it will return an indicator and tokenized data (fingerprint).
#'
#' @details Detect SQLi or XSS in parameter or request body argument.
#'  The process of detection and classification is as follows:
#'   \itemize{
#'       \item{Send argument to be tested for SQL}
#'       \item{Send argument to be tested for XSS}
#'       \item{If malicious activities have been detected then return with a `1`}
#'       \item{If no malicious activity has been detected then return with a `0`}
#'   }
#'
#' @param argument A string containing a URL-decoded parameter, request body,
#'  or header argument.
#'
#' @return Returns a binary integer indicating whether the argument contained a
#'  malicious element (`1`) or not (`0`).
#'  
#' @importFrom magrittr %>% %<>% %$% %T>%
#'
#' @useDynLib injectoR libinjection_sqli libinjection_xss
#'
#' @export


detectAttack <- function(argument) {
  argumentClean <- iconv(
    x = argument,
    from = "ISO-8859-1",
    to = "UTF-8")
  
  argumentLength <- argumentClean %>%
    nchar
  
  # Detect for SQLi
  isSQLi <- .C(
    injectoR:::libinjection_sqli,
    s = argumentClean,
    slen = argumentLength,
    b = 9L,
    fin0 = "",
    fin1 = "",
    fin2 = "",
    fin3 = "",
    fin4 = "")

  # Detect for XSS
  isXSS <- .C(
    injectoR:::libinjection_xss,
    s = argumentClean,
    len = argumentLength,
    b = 9L)$b

  # Store results in a dataframe
  detectionResults <- data.frame(
    argument = argumentClean,
    length = argumentLength,
    isSQLi = isSQLi$b,
    isXSS = isXSS,
    fingerprint = isSQLi[4:length(isSQLi)] %>%
      paste(collapse = ''))

  return(detectionResults)
}
