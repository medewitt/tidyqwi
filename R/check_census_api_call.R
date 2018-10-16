#' A helper function to help parse API calls from the census
#' @param call a returned call from the US Census API
#' @import xml2
#' @import httr
#' @export


check_census_api_call <- function(call){
  httr::content(call, as = "text", encoding = "UTF-8") %>%
    xml2::as_xml_document() %>%
    xml2::xml_find_all("body") %>%
    xml2::xml_text() %>%
    gsub("\\s{2}", "", x = .) %>%
    gsub("^\\s", "", x = .)
}
