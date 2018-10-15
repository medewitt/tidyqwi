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

The purpose of ``tidyqqi`` is to access the US Census Bureau Quarterly Workforce Indicators API and return a tidy data frame for further analysis. The API has specific requirements that force a user to specify a single state per each API call. Additionally, there is a limit on how much data can be queried in a single API call making calls for many industries and associated cross-tabulations challenging. These aspects make retrieving multi-state, multi-industry data difficult and time-consuming.

Taking inspiration from tidycensus [@tidycensus] which has provided a robust method for accessing US Census data from the decennial census and American Community Survey, ``tidyqwi`` provides a friendly way to interface with the US Census' available API for Quarterly Workforce Indicators. ``Tidyqwi`` provides a way to easily access the US Census' API with multi-state calls, over multiple years, variables and cross-tabulations. The ``tidy_qwi`` function allows the user to specify key fields for retrieval (years of interest, quarters of interest, variables of interest, industry level, specific states, county/ CBSA level, and the cross tabulation among other fields). Relying heavily on @httr and @jsonlite a API is structured following the [API documentation](https://www.census.gov/data/developers/data-sets/qwi.html)[@census-qwi]. The call is then submitted to the US Census Bureau using the user's API Key (which can be requested from the US Census Bureau [here](https://api.census.gov/data/key_signup.html)). 

The tbl_df object that is returned also contains the data labels courtesy of @Hmisc for easier interpretation of the variable names. This allows researchers the ability to retrieve data for further analysis without having to specify multiple queries. ``Tidyqwi`` thus provides a way for researchers working in economics and econometrics a way to access the Quarterly Workforce Indicators in an ergonomic and repeatable way.


# References
