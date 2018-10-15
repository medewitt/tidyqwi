---
title: 'tidyqwi: A Tidy Approach to Accessing The US Census Bureau's Quarterly Workforce Indicators'
tags:
  - r
  - national statistics
  - US census
  - Economics
  - Econometrics
authors:
 - name: Michael E DeWitt, Jr
   orcid: 0000-0001-8940-1967
   affiliation: 1
 - name: Mona Ahmadiani
   orcid: 0000-0002-1269-5685
   affiliation: "1, 2"
affiliations:
 - name: Wake Forest University
   index: 1
 - name: Eudaimonia Institute
   index: 2
date: 31 October 2018
bibliography: paper.bib
---

# Summary

The purpose of `tidyqqi` is to access the US Census Bureau Quarterly Workforce Indicators API and return a tidy data frame for further analysis. The API has specific requirements that force a user to specify a single state per each API call. Additionally, there is a limit on how much data can be queried in a single API call making calls for many industries and associated cross-tabulations challenging. These aspects make retrieving multi-state, multi-industry data difficult and time-consuming. 

Tidyqwi provides a way to easily access the US Census' API with multi-state calls, over multiple years, variables and cross-tabulations. The tidy_qwi function allows the user to specify key fields for retrieval (years of interest, quarters of interest, variables of interest, industry level, specific states, county/ CBSA level, and the crosstabulation among other fields). The tbl_df object that is returned also contains the data labels courtesy of @Hmisc for easier interpretation of the variable names. This allows researchers the ability to retrieve data for further analysis without having to specify multiple queries. The inspiration for this package is from tidycensus [@tidycensus] which has provided a robust method for accessing US Census data from the dicenial census and American Community Survey. 

-![Fidgit deposited in figshare.](figshare_article.png)

# References
