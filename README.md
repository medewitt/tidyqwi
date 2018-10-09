
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidyqwi

The goal of tidyqwi is to make accessing the US Census Bureau’s
Quarterly Workforce Indicators Easier in a tidy format. This is a work
in progress\!

## Installation

``` r
devtools::install_github("medewitt/tidyqi")
```

After installation you can load and retrieve the desired data\!

``` r
library(tidyqwi)
#> Warning: replacing previous import 'dplyr::collapse' by 'glue::collapse'
#> when loading 'tidyqwi'

output <- get_qwi(years = "2010", states = "37", apikey = censuskey)
#> 
  |                                                                       
  |                                                                 |   0%
  |                                                                       
  |=================================================================| 100%
```

And look at your data:

``` r
head(output)
#> # A tibble: 6 x 42
#>   Emp   sEmp  EmpEnd sEmpEnd EmpS  sEmpS EmpTotal sEmpTotal EmpSpv sEmpSpv
#>   <S3:> <S3:> <S3: > <S3: l> <S3:> <S3:> <S3: la> <S3: lab> <S3: > <S3: l>
#> 1 124   1     117    1       108   1     153      1         117    1      
#> 2  NA   5      NA    5        NA   5      NA      5          NA    5      
#> 3   6   1      10    9         6   1      15      1           6    1      
#> 4   7   1       7    9         6   1      12      1           7    1      
#> 5  23   1      21    1        21   1      29      1          22    1      
#> 6  33   1      28    1        28   1      36      1          31    1      
#> # ... with 32 more variables: HirA <S3: labelled>, sHirA <S3: labelled>,
#> #   HirN <S3: labelled>, sHirN <S3: labelled>, HirR <S3: labelled>,
#> #   sHirR <S3: labelled>, Sep <S3: labelled>, sSep <S3: labelled>,
#> #   HirAEnd <S3: labelled>, sHirAEnd <S3: labelled>, SepBeg <S3:
#> #   labelled>, sSepBeg <S3: labelled>, HirAEndRepl <S3: labelled>,
#> #   sHirAEndRepl <S3: labelled>, HirAEndR <S3: labelled>, sHirAEndR <S3:
#> #   labelled>, SepBegR <S3: labelled>, sSepBegR <S3: labelled>, SepS <S3:
#> #   labelled>, sSepS <S3: labelled>, SepSnx <S3: labelled>, sSepSnx <S3:
#> #   labelled>, TurnOvrS <S3: labelled>, sTurnOvrS <S3: labelled>,
#> #   year <S3: labelled>, quarter <S3: labelled>, agegrp <S3: labelled>,
#> #   ownercode <S3: labelled>, seasonadj <S3: labelled>, industry <S3:
#> #   labelled>, state <S3: labelled>, MSA <S3: labelled>
```

And there are labels added

``` r
Hmisc::describe(output)
#> output 
#> 
#>  42  Variables      29196  Observations
#> ---------------------------------------------------------------------------
#> Emp : Beginning-of-Quarter Employment: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    27773     1423     3973        1     1018     1743        3        7 
#>      .25      .50      .75      .90      .95 
#>       25      112      472     1833     4102 
#> 
#> lowest :      0      1      2      3      4, highest: 100691 104794 104933 105868 106659
#> ---------------------------------------------------------------------------
#> sEmp : Flag for Beginning-of-Quarter Employment: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.509    2.513    2.444 
#>                             
#> Value          1     5     9
#> Frequency  22963  1423  4810
#> Proportion 0.787 0.049 0.165
#> ---------------------------------------------------------------------------
#> EmpEnd : End-of-Quarter Employment: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    27830     1366     3978        1     1025     1754      3.0      7.0 
#>      .25      .50      .75      .90      .95 
#>     26.0    113.0    474.8   1837.1   4136.5 
#> 
#> lowest :      0      1      2      3      4, highest: 101928 104612 105036 106905 107030
#> ---------------------------------------------------------------------------
#> sEmpEnd : Flag for End-of-Quarter Employment: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.506    2.507    2.438 
#>                             
#> Value          1     5     9
#> Frequency  23013  1366  4817
#> Proportion 0.788 0.047 0.165
#> ---------------------------------------------------------------------------
#> EmpS : Full-Quarter Employment (Stable): Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    27605     1591     3777        1    919.2     1579        3        6 
#>      .25      .50      .75      .90      .95 
#>       22       98      425     1624     3788 
#> 
#> lowest :     0     1     2     3     4, highest: 87898 96709 97322 98712 98929
#> ---------------------------------------------------------------------------
#> sEmpS : Flag for Full-Quarter Employment (Stable): Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.522    2.548    2.485 
#>                             
#> Value          1     5     9
#> Frequency  22752  1591  4853
#> Proportion 0.779 0.054 0.166
#> ---------------------------------------------------------------------------
#> EmpTotal : Employment-Reference Quarter: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    27987     1209     4327        1     1204     2052        4        9 
#>      .25      .50      .75      .90      .95 
#>       33      140      570     2234     4870 
#> 
#> lowest :      0      1      2      3      4, highest: 116952 117561 118721 118745 123743
#> ---------------------------------------------------------------------------
#> sEmpTotal : Flag for Employment-Reference Quarter: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3     0.49    2.461    2.382 
#>                             
#> Value          1     5     9
#> Frequency  23259  1209  4728
#> Proportion 0.797 0.041 0.162
#> ---------------------------------------------------------------------------
#> EmpSpv : Full-Quarter Employment in the Previous Quarter: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    27567     1629     3758        1    916.3     1574        3        6 
#>      .25      .50      .75      .90      .95 
#>       21       98      424     1622     3768 
#> 
#> lowest :     0     1     2     3     4, highest: 89817 97117 97357 98209 98782
#> ---------------------------------------------------------------------------
#> sEmpSpv : Flag for Full-Quarter Employment in the Previous Quarter: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.525    2.556    2.494 
#>                             
#> Value          1     5     9
#> Frequency  22704  1629  4863
#> Proportion 0.778 0.056 0.167
#> ---------------------------------------------------------------------------
#> HirA : Hires All: Counts (Accessions) 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    26314     2882     1771    0.999      206    348.6        0        0 
#>      .25      .50      .75      .90      .95 
#>        7       27      101      371      794 
#> 
#> lowest :     0     1     2     3     4, highest: 29142 29228 29334 30801 33378
#> ---------------------------------------------------------------------------
#> sHirA : Flag for Hires All: Counts (Accessions) 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.581    2.643    2.572 
#>                             
#> Value          1     5     9
#> Frequency  21759  2882  4555
#> Proportion 0.745 0.099 0.156
#> ---------------------------------------------------------------------------
#> HirN : Hires New: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    25978     3218     1647    0.998    179.5    305.2      0.0      0.0 
#>      .25      .50      .75      .90      .95 
#>      6.0     22.0     86.0    320.0    686.1 
#> 
#> lowest :     0     1     2     3     4, highest: 26564 27251 27483 28721 29649
#> ---------------------------------------------------------------------------
#> sHirN : Flag for Hires New: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.592    2.649     2.57 
#>                             
#> Value          1     5     9
#> Frequency  21569  3218  4409
#> Proportion 0.739 0.110 0.151
#> ---------------------------------------------------------------------------
#> HirR : Hires Recalls: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    23804     5392      605    0.953    31.42    53.23        0        0 
#>      .25      .50      .75      .90      .95 
#>        0        5       17       59      120 
#> 
#> lowest :     0     1     2     3     4, highest:  4393  5402  5488  5749 23099
#> ---------------------------------------------------------------------------
#> sHirR : Flag for Hires Recalls: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.691     2.91    2.771 
#>                             
#> Value          1     5     9
#> Frequency  19530  5392  4274
#> Proportion 0.669 0.185 0.146
#> ---------------------------------------------------------------------------
#> Sep : Separations: Counts 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    26273     2923     1736    0.999    197.1    332.5        0        0 
#>      .25      .50      .75      .90      .95 
#>        7       26       99      364      768 
#> 
#> lowest :     0     1     2     3     4, highest: 27154 27656 28041 28556 29584
#> ---------------------------------------------------------------------------
#> sSep : Flag for Separations: Counts 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.579    2.624    2.549 
#>                             
#> Value          1     5     9
#> Frequency  21808  2923  4465
#> Proportion 0.747 0.100 0.153
#> ---------------------------------------------------------------------------
#> HirAEnd : End-of-Quarter Hires 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    27439     1757     1356    0.998    114.3    195.7        0        0 
#>      .25      .50      .75      .90      .95 
#>        3       13       54      207      442 
#> 
#> lowest :     0     1     2     3     4, highest: 15299 15497 17424 18659 22734
#> ---------------------------------------------------------------------------
#> sHirAEnd : Flag for End-of-Quarter Hires 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        2     0.17     5.94   0.1131 
#>                       
#> Value          5     6
#> Frequency   1757 27439
#> Proportion  0.06  0.94
#> ---------------------------------------------------------------------------
#> SepBeg : Beginning-of-Quarter Separations 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    27469     1727     1300    0.998    105.4    179.4        0        0 
#>      .25      .50      .75      .90      .95 
#>        3       12       52      194      417 
#> 
#> lowest :     0     1     2     3     4, highest: 13268 13366 14396 15179 15330
#> ---------------------------------------------------------------------------
#> sSepBeg : Flag for Beginning-of-Quarter Separations 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        2    0.167    5.941   0.1113 
#>                       
#> Value          5     6
#> Frequency   1727 27469
#> Proportion 0.059 0.941
#> ---------------------------------------------------------------------------
#> HirAEndRepl : Replacement Hires 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    27368     1828      957    0.986    55.87    99.57        0        0 
#>      .25      .50      .75      .90      .95 
#>        1        4       21       88      212 
#> 
#> lowest :  -186  -172   -59   -40   -36, highest: 10021 10113 10461 10564 11619
#> ---------------------------------------------------------------------------
#> sHirAEndRepl : Flag for Replacement Hires 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        2    0.176    5.937   0.1174 
#>                       
#> Value          5     6
#> Frequency   1828 27368
#> Proportion 0.063 0.937
#> ---------------------------------------------------------------------------
#> HirAEndR : End-of-Quarter Hiring Rate 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    26421     2775      899        1   0.1558    0.156    0.000    0.021 
#>      .25      .50      .75      .90      .95 
#>    0.054    0.104    0.200    0.339    0.467 
#> 
#> lowest : 0.000 0.003 0.004 0.005 0.006, highest: 1.623 1.630 1.683 1.689 2.000
#> ---------------------------------------------------------------------------
#> sHirAEndR : Flag for End-of-Quarter Hiring Rate 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        2    0.258    5.905    0.172 
#>                       
#> Value          5     6
#> Frequency   2775 26421
#> Proportion 0.095 0.905
#> ---------------------------------------------------------------------------
#> SepBegR : Beginning-of-Quarter Separation Rate 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    26421     2775      746        1   0.1376   0.1242    0.000    0.027 
#>      .25      .50      .75      .90      .95 
#>    0.057    0.103    0.177    0.280    0.373 
#> 
#> lowest : 0.000 0.004 0.005 0.006 0.007, highest: 1.490 1.532 1.600 1.657 2.000
#> ---------------------------------------------------------------------------
#> sSepBegR : Flag for Beginning-of-Quarter Separation Rate 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        2    0.258    5.905    0.172 
#>                       
#> Value          5     6
#> Frequency   2775 26421
#> Proportion 0.095 0.905
#> ---------------------------------------------------------------------------
#> SepS : Separations (Stable): Counts (Flow out of Full-Quarter Employment) 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    24540     4656     1090    0.991    81.68    137.2        0        0 
#>      .25      .50      .75      .90      .95 
#>        3       11       42      157      329 
#> 
#> lowest :    0    1    2    3    4, highest: 8434 8867 8999 9061 9701
#> ---------------------------------------------------------------------------
#> sSepS : Flag for Separations (Stable): Counts (Flow out of Full-Quarter Employment) 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3    0.646    2.738    2.619 
#>                             
#> Value          1     5     9
#> Frequency  20526  4656  4014
#> Proportion 0.703 0.159 0.137
#> ---------------------------------------------------------------------------
#> SepSnx : Separations (Stable), Next Quarter: Counts (Flow out of Full-Quarter Employment) 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    24538     4658     1093    0.991    83.92      141        0        0 
#>      .25      .50      .75      .90      .95 
#>        3       12       43      160      336 
#> 
#> lowest :     0     1     2     3     4, highest:  8683  8877  9153  9703 10279
#> ---------------------------------------------------------------------------
#> sSepSnx : Flag for Separations (Stable), Next Quarter: Counts (Flow out of Full-Quarter Employment) 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        3     0.65     2.76    2.644 
#>                             
#> Value          1     5     9
#> Frequency  20445  4658  4093
#> Proportion  0.70  0.16  0.14
#> ---------------------------------------------------------------------------
#> TurnOvrS : Turnover (Stable) 
#>        n  missing distinct     Info     Mean      Gmd      .05      .10 
#>    19851     9345      532        1   0.1138  0.09511    0.000    0.029 
#>      .25      .50      .75      .90      .95 
#>    0.053    0.088    0.153    0.230    0.292 
#> 
#> lowest : 0.000 0.008 0.009 0.010 0.011, highest: 0.897 0.900 0.917 0.950 1.000
#> ---------------------------------------------------------------------------
#> sTurnOvrS : Flag for Turnover (Stable) 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        2    0.653     5.68   0.4353 
#>                       
#> Value          5     6
#> Frequency   9345 19851
#> Proportion  0.32  0.68
#> ---------------------------------------------------------------------------
#> year : Time: Year 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        1        0     2010        0 
#>                 
#> Value       2010
#> Frequency  29196
#> Proportion     1
#> ---------------------------------------------------------------------------
#> quarter : Time: Quarter 
#>        n  missing distinct     Info     Mean      Gmd 
#>    29196        0        4    0.938      2.5     1.25 
#>                               
#> Value         1    2    3    4
#> Frequency  7299 7299 7299 7299
#> Proportion 0.25 0.25 0.25 0.25
#> ---------------------------------------------------------------------------
#> agegrp : Group: Age group code (WIA) 
#>        n  missing distinct 
#>    29196        0        9 
#>                                                                 
#> Value        A00   A01   A02   A03   A04   A05   A06   A07   A08
#> Frequency   3244  3244  3244  3244  3244  3244  3244  3244  3244
#> Proportion 0.111 0.111 0.111 0.111 0.111 0.111 0.111 0.111 0.111
#> ---------------------------------------------------------------------------
#> ownercode : Group: Ownership group code 
#>        n  missing distinct    value 
#>    29196        0        1      A00 
#>                 
#> Value        A00
#> Frequency  29196
#> Proportion     1
#> ---------------------------------------------------------------------------
#> seasonadj : Seasonal Adjustment Indicator 
#>        n  missing distinct    value 
#>    29196        0        1        U 
#>                 
#> Value          U
#> Frequency  29196
#> Proportion     1
#> ---------------------------------------------------------------------------
#> industry : Group: Industry code 
#>        n  missing distinct 
#>    29196        0       20 
#>                                                                       
#> Value         11    21    22    23 31-33    42 44-45 48-49    51    52
#> Frequency   1476  1224  1440  1476  1476  1476  1476  1476  1476  1476
#> Proportion 0.051 0.042 0.049 0.051 0.051 0.051 0.051 0.051 0.051 0.051
#>                                                                       
#> Value         53    54    55    56    61    62    71    72    81    92
#> Frequency   1476  1476  1440  1476  1476  1476  1476  1476  1476  1476
#> Proportion 0.051 0.051 0.049 0.051 0.051 0.051 0.051 0.051 0.051 0.051
#> ---------------------------------------------------------------------------
#> state : State FIPS 
#>        n  missing distinct    value 
#>    29196        0        1       37 
#>                 
#> Value         37
#> Frequency  29196
#> Proportion     1
#> ---------------------------------------------------------------------------
#> MSA : metropolitan statistical area/micropolitan statistical area 
#>        n  missing distinct 
#>    29196        0       41 
#> 
#> lowest : 10620 11700 14380 14820 15500, highest: 47260 47820 48900 48980 49180
#> ---------------------------------------------------------------------------
```
