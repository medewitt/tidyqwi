#' A helper function to help parse API calls from the census
#' @param call a returned call from the US Census API
#' @import xml2
#' @import  httr
#'@examples \donttest{
#'library(tidyqwi)
#'library(httr)
#' # A single call to the API without an API Key
#'url <- "api.census.gov/data/timeseries/qwi/sa?get=Emp&for=county:198&key=NOKEY"
#'single_call <- httr::GET(url)
#'
#'# Because a non valid API key was specified an message will be returned
#'
#'check_census_api_call(single_call)
#'
#'}
#'
#' @export


check_census_api_call <- function(call){
  if(class(call) != "response"){
    stop("A valid response was not returned")
  }
  httr::content(call, as = "text", encoding = "UTF-8") %>%
    xml2::as_xml_document() %>%
    xml2::xml_find_all("body") %>%
    xml2::xml_text() %>%
    gsub(pattern = "\\s{2}", replacement = "") %>%
    gsub(pattern = "^\\s", replacement = "")
}
