
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/medewitt/tidyqwi.svg?branch=master)](https://travis-ci.org/medewitt/tidyqwi)
[![Coverage
status](https://codecov.io/gh/medewitt/tidyqwi/branch/master/graph/badge.svg)](https://codecov.io/github/medewitt/tidyqwi?branch=master)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

# tidyqwi

The goal of tidyqwi is to make accessing the US Census Bureau’s
*Quarterly Workforce Indicators* easier in a tidy format. This package
allows a user to specify the years and states of interest as well as
some of the additional parameters (desired cross tabs, MSA vs county
level data, firm size, etc) and submit them to the US Census API. This
package then stays within the US Census guidelines for API submission
for this data and returns a combined tidy dataframe for future analysis.

This is a work in progress\!

## Installation

``` r
devtools::install_github("medewitt/tidyqi")
```

After installation you can load and retrieve the desired data\!

``` r
library(tidyqwi)

nc_qwi <- get_qwi(years = "2010", 
                  states = "37", 
                  geography = "county", 
                  apikey =  census_key, 
                  quiet = TRUE, 
                  variables = c("sEmp", "Emp"), 
                  industry_level = "A")
```

And look at your data:

``` r
head(nc_qwi)
#> # A tibble: 6 x 12
#>   year  quarter agegrp sex   ownercode seasonadj industry state county
#>   <chr> <chr>   <chr>  <chr> <chr>     <chr>     <chr>    <chr> <chr> 
#> 1 2010  1       A00    0     A00       U         00       37    001   
#> 2 2010  1       A00    0     A00       U         00       37    003   
#> 3 2010  1       A00    0     A00       U         00       37    005   
#> 4 2010  1       A00    0     A00       U         00       37    007   
#> 5 2010  1       A00    0     A00       U         00       37    009   
#> 6 2010  1       A00    0     A00       U         00       37    011   
#> # ... with 3 more variables: Emp <chr>, sEmp <chr>, year_time <date>
```

And there are labels added

``` r
Hmisc::describe(nc_qwi[,2:5])
#> nc_qwi[, 2:5] 
#> 
#>  4  Variables      400  Observations
#> ---------------------------------------------------------------------------
#> quarter 
#>        n  missing distinct 
#>      400        0        4 
#>                               
#> Value         1    2    3    4
#> Frequency   100  100  100  100
#> Proportion 0.25 0.25 0.25 0.25
#> ---------------------------------------------------------------------------
#> agegrp 
#>        n  missing distinct    value 
#>      400        0        1      A00 
#>               
#> Value      A00
#> Frequency  400
#> Proportion   1
#> ---------------------------------------------------------------------------
#> sex 
#>        n  missing distinct    value 
#>      400        0        1        0 
#>               
#> Value        0
#> Frequency  400
#> Proportion   1
#> ---------------------------------------------------------------------------
#> ownercode 
#>        n  missing distinct    value 
#>      400        0        1      A00 
#>               
#> Value      A00
#> Frequency  400
#> Proportion   1
#> ---------------------------------------------------------------------------
```

Please note that the ‘tidyqwi’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
