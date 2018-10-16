library(tidyqwi)

test_that("API has been specified", {
  expect_error(get_qwi(years = c(2010, 2011), states = c("01")),
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


test_that("All the data frames have been sucessfully loaded",
          {
            expect_equal(nrow(state_info), 51)
            expect_equal(nrow(owner_codes), 3)
            expect_equal(nrow(industry_labels), 433)
            expect_equal(nrow(qwi_var_names), 86)

          })

