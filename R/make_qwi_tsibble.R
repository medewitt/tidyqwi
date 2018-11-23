#' Convert to A Tibble
#' @param df The dataframe returns from the get_qwi function
#' @return a tsibble object with the correct nexting
#'
#'
#' @export
#' @import tsibble
#'

make_qwi_tsibble <- function(df){
  #Need to Determine Nesting Structure Based on Columns if nesting is not specified
  col_names <- names(df)

  if(!"state" %in% col_names){
    stop("This is not the standard qwi data frame. Please specify keys.")
  }

  if("metropolitan statistical area/micropolitan statistical area" %in% col_names){
    message("Using MSA")
    #id_var <- "msa | state,  agegrp, ownercode, sex, industry"
    as_tsibble(df, key = id(`metropolitan statistical area/micropolitan statistical area`| state, agegrp, ownercode, sex, industry),
               index = year_time)
  } else{
    message("Using County")
    #id_var <- "county | state state, agegrp, ownercode, sex, industry"

    as_tsibble(df, key = id(county| state, agegrp, ownercode, sex, industry),
               index = year_time)

  }
  #nesting_structure <<- rlang::enquo(id_var)

}
