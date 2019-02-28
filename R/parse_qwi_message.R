#'@title parse_qwi
#'@description An internally used function to parse the returned API call.
#'@param x a returned call response from the US Census QWI API
#'@export

parse_qwi_message <- function(x) {
  if (class(x) != "response") {
    stop("You have not passed a valid response")
  }
  y <- dplyr::as_data_frame(
    jsonlite::fromJSON(
      httr::content(x, as = "text", encoding = "UTF-8")
      )
    )
  y <- stats::setNames(y, y[1, ])
  y <- y[-1, ]
  y <- tidyr::gather(y, "parameter", "value",-c(2:ncol(y)))
}
