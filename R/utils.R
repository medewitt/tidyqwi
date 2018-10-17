# Some utility functions

.onLoad <- function(libname, pkgname) {
  utils::data("industry_labels", package=pkgname, envir=parent.env(environment()))
  utils::data("owner_codes", package=pkgname, envir=parent.env(environment()))
  utils::data("qwi_var_names", package=pkgname, envir=parent.env(environment()))
  utils::data("state_info", package=pkgname, envir=parent.env(environment()))
}
