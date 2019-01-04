library(tidyqwi)

test_that("API has been specified", {
  expect_error(get_qwi(years = c(2010, 2011), states = c("01")),
               "Please specifiy a valid API Key.")
})

test_that("Checks fips converter works", {
  expect_error(get_qwi(years = c(2010, 2011), states = c("nc  ")),
               "Please specifiy a valid API Key.")
})

test_that("Valid State FIPS have Been Entered", {
  expect_error(get_qwi(years = c(2010, 2011), states = c(01)),
               "1 contains an invalid fips code.\nPlease check the state_info table for details\non valid fips codes.")
})

test_that("Catch for years prior to data availability works", {
  expect_error(get_qwi(years = c(1980, 2011), states = c("01"), apikey = "MYKEY"),
               "1980 is before 1990.\nThe QWI data are only available after 1990.")
})

test_that("Catch for correct variables", {
  expect_error(get_qwi(years = c(2011), states = c("01"), apikey = "MYKEY", variables = "AA"),
               "You have not specified a valid variable name")
})

test_that("Catch for endpoint checking", {
  expect_error(get_qwi(years = c(2011), states = c("01"), apikey = "MYKEY", endpoint = "RR"),
               "You have not specified a valid endpoint one of `sa``, `se``, or `rh`")
})

test_that("Catch for geography", {
  expect_error(get_qwi(years = c(2011), states = c("01"), apikey = "MYKEY", geography = "country"),
               "Please enter a county or cbsa in the `geography` field")
})

test_that("Catch for geography", {
  expect_error(get_qwi(years = c(2011), states = c("01"), apikey = "MYKEY", seasonadj = "r"),
               "Please specify a valid seasonal adjustment parameter of `S` or `U`")
})

# I need to rethink through this test
test_that("Valid API Key", {
  expect_error(get_qwi(years = c(2011), states = c("01"), apikey = "A"),
               "A valid key must be included with each data API request. You included a key with this request, however, it is not valid. Please check your key and try again.If you do not have a key you my sign up for one here. ")
})

# check that labels fails
test_that("add labels", {
  expect_error(add_qwi_labels(mtcars),
               "A valid qwi object has not been passed to this function")
})

# Check parsing fails

test_that("parsing for post only", {
  expect_error(parse_qwi_message(mtcars), "You have not passed a valid response")
})

test_that("All the data frames have been sucessfully loaded",
          {
            expect_equal(nrow(state_info), 51)
            expect_equal(nrow(owner_codes), 3)
            expect_equal(nrow(industry_labels), 433)
            expect_equal(nrow(qwi_var_names), 86)

          })

test_that("fips code converter works",
          {
            expect_equal(converted_fips("nc    "), "37")
          })

test_that("Try Catch helper function returns correct message",
          {
            mock_function <- function(a){
              if(a == 1){
                stop("Now")
              }
              if(a==2){
                warning("I'm warning you")
              }
              if(a==3){
                message("Hi")
              }
            }
            expect_equal(show_condition(mock_function(1)), "error")
            expect_equal(show_condition(mock_function(2)), "warning")
            expect_equal(show_condition(mock_function(3)), "message")
          })
