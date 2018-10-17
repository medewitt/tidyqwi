#' A function to check if a valid state number or fips is passed
#'
#' @param fips the state abbreviation or fips code vector
#'
#' @export
#'
converted_fips <- function(fips){

  # Check if it is a number or a string

  if(sum(is.na(suppressWarnings(as.numeric(x)))) >0){
    # Its a string. Guess is that it is state code.

    converted_abbreviation <- stringr::str_trim(fips) %>%
      stringr::str_to_upper()

    fips <- state_info %>%
      dplyr::filter(state_abreviation %in% converted_abbreviation) %>%
      dplyr::pull(state_fips)

    return(fips)

  } else{
    #It's a number. We would be able to pass them on
    return(fips)
  }

}


