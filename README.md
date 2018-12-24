
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

nc_qwi <- get_qwi(years = "2010", states = "37", apikey = census_key, quiet = TRUE)
```

And look at your data:

``` r
head(nc_qwi)
#> # A tibble: 6 x 44
#>     Emp  sEmp EmpEnd sEmpEnd  EmpS sEmpS EmpTotal sEmpTotal EmpSpv sEmpSpv
#>   <dbl> <dbl>  <dbl>   <dbl> <dbl> <dbl>    <dbl>     <dbl>  <dbl>   <dbl>
#> 1   124     1    117       1   108     1      153         1    117       1
#> 2   920     1    949       1   836     1     1132         1    835       1
#> 3    19     1     22       1    19     1       27         1     19       1
#> 4    16     9     14       9    12     9       25         9     11       9
#> 5    45     1     45       1    38     1       56         1     41       1
#> 6  2311     1   2527       1  2156     1     3101         1   2119       1
#> # ... with 34 more variables: HirA <dbl>, sHirA <dbl>, HirN <dbl>,
#> #   sHirN <dbl>, HirR <dbl>, sHirR <dbl>, Sep <dbl>, sSep <dbl>,
#> #   HirAEnd <dbl>, sHirAEnd <dbl>, SepBeg <dbl>, sSepBeg <dbl>,
#> #   HirAEndRepl <dbl>, sHirAEndRepl <dbl>, HirAEndR <dbl>,
#> #   sHirAEndR <dbl>, SepBegR <dbl>, sSepBegR <dbl>, SepS <dbl>,
#> #   sSepS <dbl>, SepSnx <dbl>, sSepSnx <dbl>, TurnOvrS <dbl>,
#> #   sTurnOvrS <dbl>, year <dbl>, quarter <dbl>, agegrp <chr>, sex <chr>,
#> #   ownercode <chr>, seasonadj <chr>, industry <chr>, state <chr>,
#> #   `metropolitan statistical area/micropolitan statistical area` <chr>,
#> #   year_time <date>
```

And there are labels added

``` r
Hmisc::describe(nc_qwi[,2:5])
#> nc_qwi[, 2:5] 
#> 
#>  4  Variables      3244  Observations
#> ---------------------------------------------------------------------------
#> sEmp : Flag for Beginning-of-Quarter Employment: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3     0.43    2.274     2.14 
#>                             
#> Value          1     5     9
#> Frequency   2685    85   474
#> Proportion 0.828 0.026 0.146
#> ---------------------------------------------------------------------------
#> EmpEnd : End-of-Quarter Employment: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3160       84     2130        1     4512     6997     59.0    110.9 
#>      .25      .50      .75      .90      .95 
#>    312.8    972.5   3007.2   9683.1  22439.7 
#> 
#> lowest :      0      3     11     12     13, highest: 101928 104612 105036 106905 107030
#> ---------------------------------------------------------------------------
#> sEmpEnd : Flag for End-of-Quarter Employment: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.432    2.282    2.152 
#>                             
#> Value          1     5     9
#> Frequency   2682    84   478
#> Proportion 0.827 0.026 0.147
#> ---------------------------------------------------------------------------
#> EmpS : Full-Quarter Employment (Stable): Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3161       83     2060        1     4014     6240       52      101 
#>      .25      .50      .75      .90      .95 
#>      271      842     2641     8696    20366 
#> 
#> lowest :     0     8     9    10    11, highest: 87898 96709 97322 98712 98929
#> ---------------------------------------------------------------------------
```

Please note that the ‘tidyqwi’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
