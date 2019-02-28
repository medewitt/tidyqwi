#' QWI Variable Names
#'@description These data represent the different variable types available
#'    from the QWI API.
#' @format a dataframe with 83 rows and 9 columns:
#' \describe{
#'   \item{name}{state name}
#'   \item{label}{state fips code}
#'   \item{concept}{state abbreviation}
#'   \item{required}{requirements}
#'   \item{attributes}{details of attributes}
#'   \item{limit}{limit}
#'   \item{predicate type}{predicate type}
#'   \item{group}{group level}
#'   \item{values}{values}
#'    ...
#' }
#' @source \url{https://api.census.gov/data/timeseries/qwi/se/variables.html}

"qwi_var_names"
