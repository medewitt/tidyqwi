#' Convert to A Tibble
#' @param df The dataframe returns from the get_qwi function
#' @return a tsibble object with the correct nexting
#'
#'
#' @export
#' @import tsibble
#'

dat <- get_qwi(years = "2010", states = "37", apikey = census_key, geography = "county")
names(dat)
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
nesting_structure
test <- make_qwi_tsibble(dat)
test
id_var
class(test)
library(rlang)
nesting_structure
library(hts)
library(forecast)
fcasts2.mo <- forecast(
  test, h = 5, fmethod = "ets", level = 1,
  keep.fitted = TRUE, keep.resid = TRUE
)
test
summary(test)
dat->a#%>%
dat
as_tsibble(validate = dat,
           key = id(`metropolitan statistical area/micropolitan statistical area` | state),
           index = index(year_time))

as_tsibble(dat, key = id(county| state, agegrp, ownercode, sex, industry), index = year_time)
