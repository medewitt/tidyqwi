
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/medewitt/tidyqwi.svg?branch=master)](https://travis-ci.org/medewitt/tidyqwi)[![Coverage
status](https://codecov.io/gh/medewitt/tidyqwi/branch/master/graph/badge.svg)](https://codecov.io/github/medewitt/tidyqwi?branch=master)

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

output <- get_qwi(years = "2010", states = "37", apikey = census_key)
#> 
  |                                                                       
  |                                                                 |   0%37
  |                                                                       
  |=================================================================| 100%37373737373737373737373737373737373737
```

And look at your data:

``` r
head(output)
#> # A tibble: 6 x 44
#>   Emp   sEmp  EmpEnd sEmpEnd EmpS  sEmpS EmpTotal sEmpTotal EmpSpv sEmpSpv
#>   <S3:> <S3:> <S3: > <S3: l> <S3:> <S3:> <S3: la> <S3: lab> <S3: > <S3: l>
#> 1  124  1      117   1        108  1      153     1          117   1      
#> 2  920  1      949   1        836  1     1132     1          835   1      
#> 3   19  1       22   1         19  1       27     1           19   1      
#> 4   16  9       14   9         12  9       25     9           11   9      
#> 5   45  1       45   1         38  1       56     1           41   1      
#> 6 2311  1     2527   1       2156  1     3101     1         2119   1      
#> # ... with 34 more variables: HirA <S3: labelled>, sHirA <S3: labelled>,
#> #   HirN <S3: labelled>, sHirN <S3: labelled>, HirR <S3: labelled>,
#> #   sHirR <S3: labelled>, Sep <S3: labelled>, sSep <S3: labelled>,
#> #   HirAEnd <S3: labelled>, sHirAEnd <S3: labelled>, SepBeg <S3:
#> #   labelled>, sSepBeg <S3: labelled>, HirAEndRepl <S3: labelled>,
#> #   sHirAEndRepl <S3: labelled>, HirAEndR <S3: labelled>, sHirAEndR <S3:
#> #   labelled>, SepBegR <S3: labelled>, sSepBegR <S3: labelled>, SepS <S3:
#> #   labelled>, sSepS <S3: labelled>, SepSnx <S3: labelled>, sSepSnx <S3:
#> #   labelled>, TurnOvrS <S3: labelled>, sTurnOvrS <S3: labelled>,
#> #   year <S3: labelled>, quarter <S3: labelled>, agegrp <S3: labelled>,
#> #   sex <S3: labelled>, ownercode <S3: labelled>, seasonadj <S3:
#> #   labelled>, industry <S3: labelled>, state <S3: labelled>,
#> #   `metropolitan statistical area/micropolitan statistical area` <S3:
#> #   labelled>, year_time <date>
```

And there are labels added

``` r
Hmisc::describe(output)
#> output 
#> 
#>  44  Variables      3244  Observations
#> ---------------------------------------------------------------------------
#> Emp : Beginning-of-Quarter Employment: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3159       85     2156        1     4475     6933     60.0    111.0 
#>      .25      .50      .75      .90      .95 
#>    312.5    967.0   2973.0   9581.0  22464.0 
#> 
#> lowest :      0      3      9     10     11, highest: 100691 104794 104933 105868 106659
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
#> sEmpS : Flag for Full-Quarter Employment (Stable): Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.437    2.306    2.183 
#>                             
#> Value          1     5     9
#> Frequency   2673    83   488
#> Proportion 0.824 0.026 0.150
#> ---------------------------------------------------------------------------
#> EmpTotal : Employment-Reference Quarter: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3156       88     2223        1     5339     8236     76.0    129.0 
#>      .25      .50      .75      .90      .95 
#>    378.5   1203.5   3635.8  11179.5  26744.8 
#> 
#> lowest :      0      5      7     12     14, highest: 116952 117561 118721 118745 123743
#> ---------------------------------------------------------------------------
#> sEmpTotal : Flag for Employment-Reference Quarter: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.431    2.275    2.141 
#>                             
#> Value          1     5     9
#> Frequency   2683    88   473
#> Proportion 0.827 0.027 0.146
#> ---------------------------------------------------------------------------
#> EmpSpv : Full-Quarter Employment in the Previous Quarter: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3161       83     2056        1     3996     6209       53      102 
#>      .25      .50      .75      .90      .95 
#>      271      836     2632     8700    20374 
#> 
#> lowest :     0     8    10    11    12, highest: 89817 97117 97357 98209 98782
#> ---------------------------------------------------------------------------
#> sEmpSpv : Flag for Full-Quarter Employment in the Previous Quarter: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.438    2.308    2.187 
#>                             
#> Value          1     5     9
#> Frequency   2672    83   489
#> Proportion 0.824 0.026 0.151
#> ---------------------------------------------------------------------------
#> HirA : Hires All: Counts (Accessions) 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3137      107     1202        1    864.5     1360        6       14 
#>      .25      .50      .75      .90      .95 
#>       50      179      591     1903     3869 
#> 
#> lowest :     0     2     3     4     5, highest: 29142 29228 29334 30801 33378
#> ---------------------------------------------------------------------------
#> sHirA : Flag for Hires All: Counts (Accessions) 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.463     2.38     2.28 
#>                             
#> Value          1     5     9
#> Frequency   2631   107   506
#> Proportion 0.811 0.033 0.156
#> ---------------------------------------------------------------------------
#> HirN : Hires New: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3140      104     1122        1    743.2     1180        5       11 
#>      .25      .50      .75      .90      .95 
#>       39      143      508     1568     3355 
#> 
#> lowest :     0     2     3     4     5, highest: 26564 27251 27483 28721 29649
#> ---------------------------------------------------------------------------
#> sHirN : Flag for Hires New: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.461    2.379    2.279 
#>                             
#> Value          1     5     9
#> Frequency   2633   104   507
#> Proportion 0.812 0.032 0.156
#> ---------------------------------------------------------------------------
#> HirR : Hires Recalls: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     2976      268      506    0.999    126.9    196.3      0.0      3.0 
#>      .25      .50      .75      .90      .95 
#>      9.0     30.0     89.0    279.5    544.8 
#>                                                                       
#> Value          0   200   400   600   800  1000  1200  1400  1600  1800
#> Frequency   2303   391   116    47    43    23    12     8     8     8
#> Proportion 0.774 0.131 0.039 0.016 0.014 0.008 0.004 0.003 0.003 0.003
#>                                                           
#> Value       2000  2200  2600  2800  3000  3400  3800 23000
#> Frequency      5     3     3     1     1     1     2     1
#> Proportion 0.002 0.001 0.001 0.000 0.000 0.000 0.001 0.000
#> ---------------------------------------------------------------------------
#> sHirR : Flag for Hires Recalls: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.607    2.845    2.812 
#>                             
#> Value          1     5     9
#> Frequency   2362   268   614
#> Proportion 0.728 0.083 0.189
#> ---------------------------------------------------------------------------
#> Sep : Separations: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3128      116     1198        1    828.4     1294      6.0     15.0 
#>      .25      .50      .75      .90      .95 
#>     50.0    182.5    575.2   1812.0   3771.6 
#> 
#> lowest :     0     2     3     4     5, highest: 27154 27656 28041 28556 29584
#> ---------------------------------------------------------------------------
#> sSep : Flag for Separations: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.462    2.364    2.258 
#>                             
#> Value          1     5     9
#> Frequency   2633   116   495
#> Proportion 0.812 0.036 0.153
#> ---------------------------------------------------------------------------
#> HirAEnd : End-of-Quarter Hires 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3160       84      953        1    496.7    785.4        3        7 
#>      .25      .50      .75      .90      .95 
#>       27       98      339     1106     2342 
#> 
#> lowest :     0     1     2     3     4, highest: 15299 15497 17424 18659 22734
#> ---------------------------------------------------------------------------
#> sHirAEnd : Flag for End-of-Quarter Hires 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        2    0.076    5.974  0.05046 
#>                       
#> Value          5     6
#> Frequency     84  3160
#> Proportion 0.026 0.974
#> ---------------------------------------------------------------------------
#> SepBeg : Beginning-of-Quarter Separations 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3159       85      936        1    458.6    717.1        3        8 
#>      .25      .50      .75      .90      .95 
#>       27       92      331     1028     2227 
#> 
#> lowest :     0     1     2     3     4, highest: 13268 13366 14396 15179 15330
#> ---------------------------------------------------------------------------
#> sSepBeg : Flag for Beginning-of-Quarter Separations 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        2    0.077    5.974  0.05105 
#>                       
#> Value          5     6
#> Frequency     85  3159
#> Proportion 0.026 0.974
#> ---------------------------------------------------------------------------
#> HirAEndRepl : Replacement Hires 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3156       88      724        1    276.5    445.8      1.0      3.0 
#>      .25      .50      .75      .90      .95 
#>     11.0     47.0    186.2    561.5   1359.8 
#> 
#> lowest :   -40    -6    -3    -2    -1, highest: 10021 10113 10461 10564 11619
#> ---------------------------------------------------------------------------
#> sHirAEndRepl : Flag for Replacement Hires 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        2    0.079    5.973   0.0528 
#>                       
#> Value          5     6
#> Frequency     88  3156
#> Proportion 0.027 0.973
#> ---------------------------------------------------------------------------
#> HirAEndR : End-of-Quarter Hiring Rate 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3149       95      394        1   0.1176  0.08771   0.0260   0.0380 
#>      .25      .50      .75      .90      .95 
#>   0.0640   0.0960   0.1410   0.2100   0.2836 
#> 
#> lowest : 0.000 0.003 0.006 0.007 0.008, highest: 0.827 0.943 1.024 1.103 2.000
#> ---------------------------------------------------------------------------
#> sHirAEndR : Flag for End-of-Quarter Hiring Rate 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        2    0.085    5.971  0.05687 
#>                       
#> Value          5     6
#> Frequency     95  3149
#> Proportion 0.029 0.971
#> ---------------------------------------------------------------------------
#> SepBegR : Beginning-of-Quarter Separation Rate 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3149       95      360        1   0.1132  0.08152    0.028    0.039 
#>      .25      .50      .75      .90      .95 
#>    0.059    0.095    0.141    0.205    0.253 
#> 
#> lowest : 0.000 0.006 0.007 0.008 0.009, highest: 0.698 0.711 0.729 1.136 2.000
#> ---------------------------------------------------------------------------
#> sSepBegR : Flag for Beginning-of-Quarter Separation Rate 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        2    0.085    5.971  0.05687 
#>                       
#> Value          5     6
#> Frequency     95  3149
#> Proportion 0.029 0.971
#> ---------------------------------------------------------------------------
#> SepS : Separations (Stable): Counts (Flow out of Full-Quarter Employment) 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3076      168      804        1    326.9    506.9      4.0      7.5 
#>      .25      .50      .75      .90      .95 
#>     22.0     68.0    235.2    741.5   1592.2 
#> 
#> lowest :    0    1    2    3    4, highest: 8434 8867 8999 9061 9701
#> ---------------------------------------------------------------------------
#> sSepS : Flag for Separations (Stable): Counts (Flow out of Full-Quarter Employment) 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.493    2.428    2.336 
#>                             
#> Value          1     5     9
#> Frequency   2581   168   495
#> Proportion 0.796 0.052 0.153
#> ---------------------------------------------------------------------------
#> SepSnx : Separations (Stable), Next Quarter: Counts (Flow out of Full-Quarter Employment) 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     3096      148      808        1    333.6    519.3      4.0      7.0 
#>      .25      .50      .75      .90      .95 
#>     22.0     69.0    239.0    742.5   1623.8 
#> 
#> lowest :     0     1     2     3     4, highest:  8683  8877  9153  9703 10279
#> ---------------------------------------------------------------------------
#> sSepSnx : Flag for Separations (Stable), Next Quarter: Counts (Flow out of Full-Quarter Employment) 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        3    0.496    2.467    2.389 
#>                             
#> Value          1     5     9
#> Frequency   2575   148   521
#> Proportion 0.794 0.046 0.161
#> ---------------------------------------------------------------------------
#> TurnOvrS : Turnover (Stable) 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>     2967      277      263        1  0.09058  0.05439    0.031    0.038 
#>      .25      .50      .75      .90      .95 
#>    0.055    0.080    0.111    0.155    0.184 
#> 
#> lowest : 0.000 0.009 0.010 0.012 0.013, highest: 0.442 0.463 0.502 0.503 0.657
#> ---------------------------------------------------------------------------
#> sTurnOvrS : Flag for Turnover (Stable) 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        2    0.234    5.915   0.1562 
#>                       
#> Value          5     6
#> Frequency    277  2967
#> Proportion 0.085 0.915
#> ---------------------------------------------------------------------------
#> year : Time: Year 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        1        0     2010        0 
#>                
#> Value      2010
#> Frequency  3244
#> Proportion    1
#> ---------------------------------------------------------------------------
#> quarter : Time: Quarter 
#>        n  missing distinct     Info     Mean      Gmd 
#>     3244        0        4    0.938      2.5     1.25 
#>                               
#> Value         1    2    3    4
#> Frequency   811  811  811  811
#> Proportion 0.25 0.25 0.25 0.25
#> ---------------------------------------------------------------------------
#> agegrp : Group: Age group code (WIA) 
#>        n  missing distinct    value 
#>     3244        0        1      A00 
#>                
#> Value       A00
#> Frequency  3244
#> Proportion    1
#> ---------------------------------------------------------------------------
#> sex : Group: Gender code 
#>        n  missing distinct    value 
#>     3244        0        1        0 
#>                
#> Value         0
#> Frequency  3244
#> Proportion    1
#> ---------------------------------------------------------------------------
#> ownercode : Group: Ownership group code 
#>        n  missing distinct    value 
#>     3244        0        1      A00 
#>                
#> Value       A00
#> Frequency  3244
#> Proportion    1
#> ---------------------------------------------------------------------------
#> seasonadj : Seasonal Adjustment Indicator 
#>        n  missing distinct    value 
#>     3244        0        1        U 
#>                
#> Value         U
#> Frequency  3244
#> Proportion    1
#> ---------------------------------------------------------------------------
#> industry : Group: Industry code 
#>        n  missing distinct 
#>     3244        0       20 
#>                                                                       
#> Value         11    21    22    23 31-33    42 44-45 48-49    51    52
#> Frequency    164   136   160   164   164   164   164   164   164   164
#> Proportion 0.051 0.042 0.049 0.051 0.051 0.051 0.051 0.051 0.051 0.051
#>                                                                       
#> Value         53    54    55    56    61    62    71    72    81    92
#> Frequency    164   164   160   164   164   164   164   164   164   164
#> Proportion 0.051 0.051 0.049 0.051 0.051 0.051 0.051 0.051 0.051 0.051
#> ---------------------------------------------------------------------------
#> state : State FIPS 
#>        n  missing distinct    value 
#>     3244        0        1       37 
#>                
#> Value        37
#> Frequency  3244
#> Proportion    1
#> ---------------------------------------------------------------------------
#> metropolitan statistical area/micropolitan statistical area 
#>        n  missing distinct 
#>     3244        0       41 
#> 
#> lowest : 10620 11700 14380 14820 15500, highest: 47260 47820 48900 48980 49180
#> ---------------------------------------------------------------------------
#> year_time 
#>        n  missing distinct 
#>     3244        0        4 
#>                                                       
#> Value      2010-01-01 2010-03-01 2010-06-01 2010-09-01
#> Frequency         811        811        811        811
#> Proportion       0.25       0.25       0.25       0.25
#> ---------------------------------------------------------------------------
```

Please note that the ‘tidyqwi’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
