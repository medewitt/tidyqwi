#'@title get_qwi
#'@description The purpose of this function is to retrive firm information from the
#'    US Census' Quarterly Workforce Indicator API. These data can be retrieved with by
#'    specifying the states, the quarters, the years, and additional detail. This function can
#'    accept multiple states, years and quarters. This makes the data retrieval easier and stay
#'    inside of the US Census' limits on the API.
#'@param years years to fetch (e.g. 2010, or c(2010, 2011))
#'@param variables the variables you wish to fetch. Default is all.
#'@param quarters The quarters to fetch (e.g. c(1,2,3,4)) Default is all
#'@param industry_level Industries to fetch. Default is all level 2
#'@param states state fips code to fetch
#'@param endpoint US Census endpoint designation. One of "SA" for Sex * Age, "SE" for Sex by Education and "rh" for Race/Ethnicity
#'@param all_groups default to true
#'@param owner_code firm owner code
#'@param geography the US Census geography granuality (one of cbsa or county)
#'@param seasonadj seasonal adjustment factor (one of "U" or "S")
#'@param apikey your US Census API Key
#'@param quiet specify if progress is to be printed (default = FALSE)
#'
#'@return the desired data from the US Census's Quaterly Workforce API
#'@examples
#'\dontrun{
#'get_qwi(year = c(2010, 2011), states = c("01", "37"), apikey = "SECRETKEY")
#'get_qwi(year = c(2010, 2011), industry_level = 3, states = c("01", "37"), apikey = "SECRETKEY")
#'}
#'@import jsonlite
#'@import dplyr
#'@import httr
#'@import utils
#'@export

get_qwi <- function(years,
                    variables = NULL,
                    quarters = c(1,2,3,4),
                    industry_level = 2,
                    states,
                    endpoint = "sa",
                    all_groups = TRUE,
                    owner_code = TRUE,
                    geography = "cbsa",
                    seasonadj = "U",
                    apikey = NULL,
                    quiet = FALSE) {

  # Ensure quarters are properly supplied
  if(!all(quarters %in% c(1,2,3,4))){
    stop(sprintf("You have specified %s.\nPlease specify 1, 2, 3, or 4 \ne.g. quarters = c(1,2)", quarters))
  }

  # Ensure all industry specications are properly specified
  if(!all(industry_level %in% industry_labels$ind_level)){
    stop(sprintf("Please specify a valid industry label.\nCheck the `industry_labels` table for details."))
  }

  states <- converted_fips(states)

  # Verify all states are properly specified
  if(!all(states %in% state_info$state_fips)){
    stop(sprintf("%s contains an invalid fips code.\nPlease check the state_info table for details\non valid fips codes.",states))
  }

  # Check that API Key Exists
  if(is.null(apikey)){
    stop("Please specifiy a valid API Key.")
  }
  # Add a check to ensure that data called is available
  if(min(years) < 1990){
    stop(sprintf("%s is before 1990.\nThe QWI data are only available after 1990.",min(years)))
  }

  all_variables <- c("Emp", "sEmp", "EmpEnd" ,"sEmpEnd", "EmpS",
                     "sEmpS", "EmpTotal", "sEmpTotal", "EmpSpv",
                     "sEmpSpv", "HirA", "sHirA", "HirN", "sHirN",
                     "HirR", "sHirR","Sep","sSep","HirAEnd", "sHirAEnd",
                     "SepBeg","sSepBeg","HirAEndRepl", "sHirAEndRepl",
                     "HirAEndR", "sHirAEndR", "SepBegR", "sSepBegR",
                     "HirAEndRepl", "sHirAEndRepl" , "SepS", "sSepS",
                     "SepSnx", "sSepSnx", "TurnOvrS", "sTurnOvrS")

  if(is.null(variables)){
    variables <- all_variables
  }

  if(!all(variables %in% all_variables)){
    stop(sprintf("You have not specified a valid variable name"))
  }

  if(industry_level %in% c("A", 2, 3, 4)){
    industries <- industry_labels$industry[industry_labels$ind_level==industry_level]
  } else{
    stop("You have not specified a valid NAICS Number Digit in `industry_level` (e.g. A, 2, 3, 4)")
  }
  year_collapsed <- years

  quarter_collapsed <- paste(quarters, collapse = ",")


  if(!endpoint %in% c("sa", "se", "rh")){
    stop(sprintf("You have not specified a valid endpoint one of `sa``, `se``, or `rh`", endpoint))
  }

  endpoint_to_retrieve <- switch( endpoint,
                                  sa = "sa",
                                  se = "se",
                                  rh = "rh")

  if( all_groups == TRUE){
    cross_tab <- switch( endpoint,
                         sa = "&agegrp=A00&sex=0",
                         se = "&sex=0&education=E0",
                         rh = "&race=A0&=ethnicity=A0")
  } else {
    cross_tab <- switch( endpoint,
                         sa = "&agegrp=A00&agegrp=A01&agegrp=A02&agegrp=A03&agegrp=A04&agegrp=A05&agegrp=A06&agegrp=A07&agegrp=A08&sex=0&sex=1&sex=2",
                         se = "&sex=0&sex=1&sex=2&education=E0&education=E1&education=E2&education=E3&education=E4&education=E5",
                         rh = "&race=A0&race=A1&race=A2&race=A3&race=A4&race=A5&race=A6&race=A7&=ethnicity=A0&=ethnicity=A1&=ethnicity=A2")
  }

  if( owner_code == TRUE){
    owner_code <- "&ownercode=A00"
  } else {
    owner_code <- switch( owner_code,
                          A01 = "&ownercode=A00&ownercode=A01",
                          A02 = "&ownercode=A00&ownercode=A02")
  }

  if(!geography %in% c("cbsa", "county")){
    stop("Please enter a county or cbsa in the `geography` field")
  }

  if(geography == "cbsa"){
    geography <- "metropolitan+statistical+area/micropolitan+statistical+area"
  } else{
    geography <- geography
  }

  if(!seasonadj %in%c("S", "U")){
    stop("Please specify a valid seasonal adjustment parameter of `S` or `U`")
  }

  # Initialise some empty "collectors" which is where we will store our intermediate data.

  urls <- tidyr::crossing(variables,
                          endpoint_to_retrieve,
                          cross_tab,
                          owner_code,
                          year_collapsed,
                          quarter_collapsed,
                          geography,
                          industries,
                          states) %>%
    dplyr::mutate(url = paste(
      "https://api.census.gov/data/timeseries/qwi/",endpoint_to_retrieve,"?get=",
      variables,
      "&for=",geography,":*&in=state:",
      states,
      "&year=",year_collapsed,
      "&quarter=",quarter_collapsed,
      cross_tab,
      owner_code,
      "&seasonadj=",seasonadj,
      "&industry=",
      industries,
      "&key=",
      apikey,
      sep = ""
    ))

  #print(nrow(urls))

  # Do a single check to confirm that there is a valid API Key

  call <- httr::GET(urls$url[[1]])

  if(!call$status_code %in% c(200)|
     show_condition(check_census_api_call(call))!="error"){
    # IF 200 was not returned then there was an error.

    if(grepl(pattern = "valid key must", check_census_api_call(call))){
      stop(check_census_api_call(call))
    }
  }

  # Now do the vectorised version

  #results <- purrr::map(urls$url, httr::GET)
  results <- vector("list", length = nrow(urls))
  for(i in 1:nrow(urls)){
    results[[i]] <- httr::GET(urls$url[[i]])
    #print(paste0(i, "out of", nrow(urls)))
  }

  safe_parse_qwi_message <- purrr::safely(parse_qwi_message)

  output <- purrr::map(results, safe_parse_qwi_message)

  a<- purrr::transpose(output)[["result"]]

  non_error_returns <- tidyr::spread_(
    dplyr::bind_rows(
      plyr::compact(a)),
    "parameter", "value", fill = NA)


  # Add a datetime column for the quarter. This will help with time series
  # manipulation down the line
  out_data <- non_error_returns %>%
    dplyr::mutate(year_time =  dplyr::case_when(
      quarter==1~as.Date(paste(year, "1","1", sep = "-")),
      quarter==2~as.Date(paste(year, "3","1", sep = "-")),
      quarter==3~as.Date(paste(year, "6","1", sep = "-")),
      quarter==4~as.Date(paste(year, "9","1", sep = "-")),
    ))

  class(out_data) <- append(class(out_data),"qwi")
    return(out_data)
}
