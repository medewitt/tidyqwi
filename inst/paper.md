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

The purpose of ``tidyqwi`` is to access the U.S. Census Bureau Quarterly Workforce Indicators(QWI) API and return a tidy data frame for further analysis. QWI is a longitudinal dataset across NAICS industry groups that contains quarterly measures of employment flows including employment, job creation/destruction, hires, and separations among other local labor market indicators. The QWI API has specific requirements including three endpoints of "Sex/Age," "Sex/Education," and "Race/Ethnicity" for data request. Additionally, a cardinality limit of 400,000 cells has been placed on an API query requests which makes calls for many industries and associated cross-tabulations of different endpoints challenging. API calls allow for collecting data at smaller geographical levels (i.e., metropolitan/micropolitan areas and county levels) that could make the data collection tedious if it gets to 400,000 cells limit. These aspects make retrieving multi-state, multi-industry data difficult and time-consuming.

Taking inspiration from tidycensus [@tidycensus] which has provided a robust method for accessing US Census data from the decennial census and American Community Survey, ``tidyqwi`` provides a friendly way to interface with the US Census' available API for Quarterly Workforce Indicators. ``Tidyqwi`` provides a way to easily access the US Census' API with multi-state calls, over multiple years, variables and cross-tabulations. The ``tidy_qwi`` function allows the user to specify key fields for retrieval (years of interest, quarters of interest, variables of interest, industry levels (NAICS 2-digits, 3-digit, and 4-digit codes), specific states, county/ CBSA level, and the cross tabulation among other fields). Relying heavily on @httr and @jsonlite an API is structured following the [API documentation](https://www.census.gov/data/developers/data-sets/qwi.html)[@census-qwi]. The call is then submitted to the US Census Bureau using the user's API Key (which can be requested from the US Census Bureau [here](https://api.census.gov/data/key_signup.html)). Optional arguments exist for the user to specify if parallel cores are to be used to speed up calculation times.

The tbl_df object that is returned allows for labels to be added with the ``add_qwi_labels`` function if desired for easier interpretation of the variable names. This allows researchers the ability to retrieve data for further analysis without having to specify multiple queries. ``Tidyqwi`` thus provides an ergonomic and replicable way of collecting data for economics research on local labor markets.


# References



