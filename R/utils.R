# Some utility functions

.onLoad <- function(libname, pkgname) {
  utils::data("industry_labels", package=pkgname, envir=parent.env(environment()))
  utils::data("owner_codes", package=pkgname, envir=parent.env(environment()))
  utils::data("qwi_var_names", package=pkgname, envir=parent.env(environment()))
  utils::data("state_info", package=pkgname, envir=parent.env(environment()))
}

# Helper for trycatching in the code
#'@title show_condition
#'@param code the code whose message you wish to interpret
#'@export
show_condition <- function(code) {
  tryCatch(code,
           error = function(c) "error",
           warning = function(c) "warning",
           message = function(c) "message"
  )
}



