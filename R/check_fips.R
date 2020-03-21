#' A function to check if a valid state number or fips is passed
#'
#' The function verifies if a valid FIPS code was passed and
#' converts it to a unified standard for internal use.
#'
#' @param fips the state abbreviation or fips code vector
#' @return States Abbreviations or FIPs as FIP character strings
#' @examples \donttest{
#' library(tidyqwi)
#'
#' converted_fips(37)
#' converted_fips("37")
#' converted_fips("NC")
#' converted_fips("nc")
#'
#' }
#'
#' @return a vector with the State FIPS code
#'
#' @export
converted_fips <- function(fips){

  # Check if it is a number or a string

  if(sum(is.na(suppressWarnings(as.numeric(fips)))) >0){
    # Its a string. Guess is that it is state code.

    converted_abbreviation <- stringr::str_to_upper(stringr::str_trim(fips))

    fips <- dplyr::filter( state_info,
                           state_info$state_abreviation %in% converted_abbreviation)
    fips <- dplyr::pull(fips, "state_fips")

    return(fips)

  } else{
    #It's a number. We would be able to pass them on
    return(fips)
  }

}


