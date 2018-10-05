# Initialise some empty "collectors" which is where we will store our intermediate data.

collector <- list()
collect_industry <- data_frame()
for(j in seq_along(state_seq)) {
  state <- state_seq[[j]]
  print(state_seq[[j]])

  for (i in seq_along(industry_seq)) {
    industry <- industry_seq[[i]]
    print(industry_seq[[i]])

    url <-
      paste(
        "https://api.census.gov/data/timeseries/qwi/sa?get=",
        varname,
        "&for=metropolitan+statistical+area/micropolitan+statistical+area:*&in=state:",
        state,
        "&year=",year_collapsed,"&quarter=1,2,3,4",
        "&agegrp=A00&agegrp=A01&agegrp=A02&agegrp=A03&agegrp=A04&agegrp=A05&agegrp=A06&agegrp=A07&agegrp=A08",
        "&ownercode=A00",
        "&seasonadj=U",
        "&industry=",
        industry,
        "&key=",
        APIkey,
        sep = ""
      )


    call <- GET(url)
    print(call$status_code)
    if(!call$status_code %in% c(200, 202)){
      # 500 means that message failed If not 500 then there was an OK
      next(i)

    } else{
      # Keep going if there isn't an error
      dat <- as_data_frame(fromJSON(content(call, as = "text")))
      colnames(dat) <- dat[1, ]
      dat <- dat[-1, ]

      # Keep adding to the data frame
      collect_industry <- bind_rows(collect_industry, dat)
    }

  }
  # Store for each state into a list
  collector[[j]] <- collect_industry
}

# Turn the list to a single data frame
out_data <- bind_rows(collector)
