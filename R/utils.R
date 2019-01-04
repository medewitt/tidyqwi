# Some utility functions

.onLoad <- function(libname, pkgname) {
  utils::data("industry_labels", package=pkgname, envir=parent.env(environment()))
  utils::data("owner_codes", package=pkgname, envir=parent.env(environment()))
  utils::data("qwi_var_names", package=pkgname, envir=parent.env(environment()))
  utils::data("state_info", package=pkgname, envir=parent.env(environment()))
}

# Helper for trycatching in the code

show_condition <- function(code) {
  tryCatch(code,
           error = function(c) "error",
           warning = function(c) "warning",
           message = function(c) "message"
  )
}

# Helper for safe processing

safe_parse_qwi_message <- purrr::safely(parse_qwi_message)
