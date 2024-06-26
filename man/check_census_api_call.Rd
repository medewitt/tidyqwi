% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_census_api_call.R
\name{check_census_api_call}
\alias{check_census_api_call}
\title{A helper function to help parse API calls from the census}
\usage{
check_census_api_call(call)
}
\arguments{
\item{call}{a returned call from the US Census API}
}
\value{
a string vector with the message from the US Census API
}
\description{
The function verifies that API call was sucessful.
If the call was not sucessful, this function passes the
message received from the US Census API for further troublshooting,
}
\examples{

if(FALSE){
library(tidyqwi)
library(httr)
# A single call to the API without an API Key
url <- "api.census.gov/data/timeseries/qwi/sa?get=Emp&for=county:198&key=NOKEY"
single_call <- httr::GET(url)
stop_for_status(single_call)

# Because a non valid API key was specified an message will be returned

check_census_api_call(single_call)
}

}
