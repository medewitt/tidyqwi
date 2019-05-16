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
 - name: Adam S. Hyde
   orcid: 0000-0003-1205-0032
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

The purpose of ``tidyqwi`` is to access the U.S. Census Bureau Quarterly Workforce Indicators(QWI) API and return a tidy data frame for further analysis. QWI is a longitudinal dataset across NAICS industry groups that contains quarterly measures of employment flows including employment, job creation/destruction, hires, separations, and turnover – as well as net employment growth among other local labor market indicators. The source data for the QWI is the Longitudinal Employer-Household Dynamics (LEHD) combined with input data from Unemployment Insurance Earnings Data (UI), Quarterly Census of Employment and Wages (QCEW), Business Dynamics Statistics (BDS), and demographic data sources (2000 and 2010 Census, American Community Survey, Social Security administrative records, and individual tax returns)(for more information: https://lehd.ces.census.gov/doc/QWI_101.pdf). The QWI has been currently employed to investigate the effects of minimum wages on employment flows [@dube2016minimum], the effects of NOx budget trading program (NBP) on labor markets in the manufacturing sector [@curtis2018loses], the effects of the housing market price on labor market flows 
[@abowd2012did], and the effects of creative destruction on the reported subjective well-being of individuals [@ahmadiani2019creative]. 

The QWI API has specific requirements including three endpoints of "Sex/Age," "Sex/Education," and "Race/Ethnicity" for data request. Additionally, a cardinality limit of 400,000 cells has been placed on an API query requests which makes calls for many industries and associated cross-tabulations of different endpoints challenging. API calls allow for collecting data at smaller geographical levels (i.e., metropolitan/micropolitan areas and county levels) that could make the data collection tedious if it gets to 400,000 cells limit. These aspects make retrieving multi-state, multi-industry data difficult and time-consuming. 

Taking inspiration from tidycensus [@tidycensus] which has provided a robust method for accessing US Census data from the decennial census and American Community Survey, ``tidyqwi`` provides a friendly way to interface with the US Census' available API for Quarterly Workforce Indicators. ``Tidyqwi`` provides a way to easily access the US Census' API with multi-state calls, over multiple years, variables and cross-tabulations. The ``tidy_qwi`` function allows the user to specify key fields for retrieval (years of interest, quarters of interest, variables of interest, industry levels (NAICS 2-digits, 3-digit, and 4-digit codes), specific states, county/ CBSA level, and the cross tabulation among other fields). Relying heavily on @httr and @jsonlite multiple API calls are constructed structured following the [API documentation](https://www.census.gov/data/developers/data-sets/qwi.html)[@census-qwi]. These calls are then submitted to the US Census Bureau using the user's API Key (which can be requested from the US Census Bureau [here](https://api.census.gov/data/key_signup.html)). Internal to the ``get_qwi`` function these multiple returned calls are aggregated into a single ``tbl_df`` object with potential missing data from the US Census represented as ``NA``.

The ``tbl_df`` object that is returned allows for labels to be added with the ``add_qwi_labels`` function if desired for easier interpretation of the variable names. This allows researchers the ability to retrieve data for further analysis without having to specify multiple queries. ``Tidyqwi`` thus provides an ergonomic and replicable way of collecting data for economics research on local labor markets.


# References








