#' @title Detect Attack
#'
#' @description This function takes in a payload and analyses it for malicious strings. 
#'  If malicious strings are found it will return an indicator and tokenized data (fingerprint).
#'
#' @details Detect SQLi or XSS in parameter or request body payload.
#'  The process of detection and classification is as follows:
#'   \itemize{
#'       \item{Send payload to be tested for SQL}
#'       \item{Send payload to be tested for XSS}
#'       \item{If malicious activities have been detected then return with a `1`}
#'       \item{If no malicious activity has been detected then return with a `0`}
#'   }
#'
#' @param payload A string containing a URL-decoded parameter, request body,
#'  or header argument.
#'
#' @return Returns a binary integer indicating whether the payload contained a
#'  malicious element (`1`) or not (`0`).
#'  
#' @importFrom magrittr %>% %<>% %$% %T>%
#'
#' @useDynLib injectoR libinjection_sqli libinjection_xss
#'
#' @export


detectAttack <- function(payload) {
  payloadClean <- iconv(
    x = payload,
    from = "ISO-8859-1",
    to = "UTF-8")
  
  payloadLength <- payloadClean %>%
    nchar
  
  # Detect for SQLi
  isSQLi <- .C(
    libinjection_sqli,
    s = payloadClean,
    slen = payloadLength,
    b = 9L,
    fin0 = "",
    fin1 = "",
    fin2 = "",
    fin3 = "",
    fin4 = "")

  # Detect for XSS
  isXSS <- .C(
    libinjection_xss,
    s = payloadClean,
    len = payloadLength,
    b = 9L)$b

  # Store results in a dataframe
  detectionResults <- data.frame(
    payload = payloadClean,
    length = payloadLength,
    isSQLi = isSQLi$b,
    isXSS = isXSS,
    fingerprint = isSQLi[4:length(isSQLi)] %>%
      paste(collapse = ''))

  return(detectionResults)
}
