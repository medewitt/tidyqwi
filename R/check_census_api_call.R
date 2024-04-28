#' A helper function to help parse API calls from the census
#'
#' The function verifies that API call was sucessful.
#' If the call was not sucessful, this function passes the
#' message received from the US Census API for further troublshooting,
#'
#'
#' @param call a returned call from the US Census API
#' @import xml2
#' @import  httr
#'@examples
#' 
#' if(FALSE){
#'library(tidyqwi)
#'library(httr)
#' # A single call to the API without an API Key
#'url <- "api.census.gov/data/timeseries/qwi/sa?get=Emp&for=county:198&key=NOKEY"
#'single_call <- httr::GET(url)
#' stop_for_status(single_call)
#'
#'# Because a non valid API key was specified an message will be returned
#'
#' check_census_api_call(single_call)
#'}
#'
#' @return a string vector with the message from the US Census API
#' @export


check_census_api_call <- function(call){

  if(class(call) != "response"){
    stop("A valid response was not returned")
  }

  returned_call <- httr::content(call, as = "text", encoding = "UTF-8")

  if( show_condition(xml2::as_xml_document(returned_call)["node"]) !="error"){
    returned_call %>%
      xml2::as_xml_document()%>%
      xml2::xml_find_all("body") %>%
      xml2::xml_text() %>%
      gsub(pattern = "\\s{2}", replacement = "") %>%
      gsub(pattern = "^\\s", replacement = "")
  } else{
    stop(paste0("\nThe following is a message from the US Census API:\n",returned_call ))
  }
}
