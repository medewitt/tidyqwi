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
#'@import glue
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
    stop(glue::glue("You have specified {quarters}.
              Please specify 1, 2, 3, or 4
              e.g. quarters = c(1,2)"))
  }

  # Ensure all industry specications are properly specified
  if(!all(industry_level %in% industry_labels$ind_level)){
    stop(glue::glue("Please specify a valid industry label.
              Check the `industry_labels` table for details."))
  }

  # Verify all states are properly specified
  if(!all(states %in% state_info$state_fips)){
    stop(glue::glue("{states} contains an invalid fips code.
              Please check the state_info table for details
              on valid fips codes."))
  }

  # Check that API Key Exists
  if(is.null(apikey)){
    stop("Please specifiy a valid API Key.")
  }
  # Add a check to ensure that data called is available
  if(min(years) < 1990){
    stop(glue::glue("{min(years)} is before 1990.
    The QWI data are only available after 1990."))
  }

  if(is.null(variables)){
    variables <- paste("Emp", "sEmp", "EmpEnd" ,"sEmpEnd", "EmpS",
                          "sEmpS", "EmpTotal", "sEmpTotal", "EmpSpv",
                          "sEmpSpv", "HirA", "sHirA", "HirN", "sHirN",
                          "HirR", "sHirR","Sep","sSep","HirAEnd", "sHirAEnd",
                          "SepBeg","sSepBeg","HirAEndRepl", "sHirAEndRepl",
                          "HirAEndR", "sHirAEndR", "SepBegR", "sSepBegR",
                          "HirAEndRepl", "sHirAEndRepl" , "SepS", "sSepS",
                          "SepSnx", "sSepSnx", "TurnOvrS", "sTurnOvrS",sep=",")
  }

  if(industry_level %in% c("A", 2, 3, 4)){
    industries <- industry_labels$industry[industry_labels$ind_level==industry_level]
  } else{
    stop("You have not specified a valid NAICS Number Digit in `industry_level` (e.g. A, 2, 3, 4)")
  }
  year_collapsed <- paste(years, collapse = ",")
  quarter_collapsed <- paste(quarters, collapse = ",")

  # Initialise some empty "collectors" which is where we will store our intermediate data.

  collector <- list()
  collect_industry <- dplyr::data_frame()
  pb <- utils::txtProgressBar(min = 0, max = length(states), style = 3)

  endpoint_to_retrieve <- switch( endpoint,
                                  sa = "sa",
                                  se = "se",
                                  rh = "rh")

  if( all_groups == TRUE){
    cross_tab <- switch( endpoint,
                         sa = "&agegrp=A00&sex=0",
                         se = "&sex=0&education=E0",
                         rg = "&race=A0&=ethnicity=A0")
  } else {
    cross_tab <- switch( endpoint,
                         sa = "&agegrp=A00&agegrp=A01&agegrp=A02&agegrp=A03&agegrp=A04&agegrp=A05&agegrp=A06&agegrp=A07&agegrp=A08&sex=0&sex=1&sex=2",
                         se = "&sex=0&sex=1&sex=2&education=E0&education=E1&education=E2&education=E3&education=E4&education=E5",
                         rg = "&race=A0&race=A1&race=A2&race=A3&race=A4&race=A5&race=A6&race=A7&=ethnicity=A0&=ethnicity=A1&=ethnicity=A2")
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



  for(j in seq_along(states)) {
    state <- states[[j]]

    setTxtProgressBar(pb, length(industries))

    for (i in seq_along(industries)) {
      industry <- industries[[i]]

      if(!quiet){
        cat(state)
        setTxtProgressBar(pb, i)
      }


      url <-
        paste(
          "https://api.census.gov/data/timeseries/qwi/",endpoint_to_retrieve,"?get=",
          variables,
          "&for=",geography,":*&in=state:",
          state,
          "&year=",year_collapsed,
          "&quarter=",quarter_collapsed,
          cross_tab,
          owner_code,
          "&seasonadj=",seasonadj,
          "&industry=",
          industry,
          "&key=",
          apikey,
          sep = ""
        )


      call <- httr::GET(url)
      #print(call$status_code)
      if(!call$status_code %in% c(200, 202)){
        # 500 means that message failed If not 500 then there was an OK
        next(i)
        print(call$status_code)
        print(url)

      } else{
        # Keep going if there isn't an error
        dat <- dplyr::as_data_frame(
          jsonlite::fromJSON(
            httr::content(call, as = "text")))

        colnames(dat) <- dat[1, ]
        dat <- dat[-1, ]

        # Keep adding to the data frame
        collect_industry <- dplyr::bind_rows(collect_industry, dat)
      }

    }
    # Store for each state into a list
    collector[[j]] <- collect_industry
  }

  # Turn the list to a single data frame
  out_data <- dplyr::bind_rows(collector)
  close(pb)

  desired_labels <- qwi_var_names[match(names(out_data), qwi_var_names$name),]
  desired_labels$`predicate type`[is.na(desired_labels$`predicate type`)] <- "string"
  desired_labels <- desired_labels[desired_labels$`predicate type`=="int",]

  out_data<- dplyr::mutate_at(out_data, vars(desired_labels$name), .funs = as.numeric)

  desired_labels <- qwi_var_names$label[match(names(out_data), qwi_var_names$name)]

  Hmisc::label(out_data, self=FALSE) <- desired_labels
  #out_data <- out_data %>%
  #  rename(MSA = `metropolitan statistical area/micropolitan statistical area`)
  #Hmisc::label(out_data[["state"]]) <- "State FIPS"
  #Hmisc::label(out_data[["MSA"]]) <- "metropolitan statistical area/micropolitan statistical area"


    return(out_data)
}
