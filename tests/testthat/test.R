library(tidyqwi)

test_that("API has been specified", {
  expect_error(get_qwi(years = c(2010, 2011), states = c("01")))
})

test_that("Valid State FIPS have Been Entered", {
  expect_error(get_qwi(years = c(2010, 2011), states = c(01)))
})

test_that("All the data frames have been sucessfully loaded",
          {
            expect_equal(nrow(state_info), 51)
            expect_equal(nrow(owner_codes), 3)
            expect_equal(nrow(industry_labels), 433)
            expect_equal(nrow(qwi_var_names), 86)

          })

