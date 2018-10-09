#'@title get_twi
#'@param year years to fetch (e.g. 2010, or c(2010, 2011))
#'@param variables the variables you wish to fetch. Default is all.
#'@param quarters The quarters to fetch (e.g. c(1,2,3,4)) Default is all
#'@param industries Industries to fetch. Default is all level 2
#'@param states state fips code to fetch
#'@param apikey your US Census API Key
#'
#'@import jsonlite
#'@import dplyr
#'@import httr
#'@import glue
#'@import utils

#'@export

get_qwi <- function(years,
                    variables = NULL,
                    quarters = c(1,2,3,4),
                    industries = "all",
                    states,
                    apikey) {
  # if(!any(quarters, c(1,2,3,4))){
  #   stop(glue("You have specified {quarters}.
  #             Please specify 1, 2, 3, or 4
  #             e.g. quarters = c(1,2)"))
  # }
  # if(!any(industries, industry_labels$industry)){
  #   stop(glue("Please specify a valid industry label.
  #             Check the `industry_labels` table for details."))
  # }
  # if(!any(states,state_info$state_fips)){
  #   stop(glue("{states} is not a valids fips code.
  #             Please check the state_info table for details
  #             on valid fip codes."))
  # }
  #
  # if(is.null(apikey)){
  #   stop("Please specifiy a valid API Key.")
  # }
  #
  # if(min(years) < 1990){
  #   stop(glue("{min(year)} is before 1990.
  #   The QWI data are only available after 1990."))
  # }
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

  if(industries == "all"){
    industries <- industry_labels$industry[industry_labels$ind_level=="2"]
  }
  year_collapsed <- paste(years, collapse = ",")
  quarter_collapsed <- paste(quarters, collapse = ",")

  # Initialise some empty "collectors" which is where we will store our intermediate data.

  collector <- list()
  collect_industry <- dplyr::data_frame()
  pb <- utils::txtProgressBar(min = 0, max = length(states), style = 3)
  for(j in seq_along(states)) {
    state <- states[[j]]

    setTxtProgressBar(pb, j)

    for (i in seq_along(industries)) {
      industry <- industries[[i]]
      #print(industries[[i]])

      url <-
        paste(
          "https://api.census.gov/data/timeseries/qwi/sa?get=",
          variables,
          "&for=metropolitan+statistical+area/micropolitan+statistical+area:*&in=state:",
          state,
          "&year=",year_collapsed,
          "&quarter=",quarter_collapsed,
          "&agegrp=A00&agegrp=A01&agegrp=A02&agegrp=A03&agegrp=A04&agegrp=A05&agegrp=A06&agegrp=A07&agegrp=A08",
          "&ownercode=A00",
          "&seasonadj=U",
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
  out_data <- out_data %>%
    rename(MSA = `metropolitan statistical area/micropolitan statistical area`)
  Hmisc::label(out_data[["state"]]) <- "State FIPS"
  Hmisc::label(out_data[["MSA"]]) <- "metropolitan statistical area/micropolitan statistical area"


    return(out_data)
}
