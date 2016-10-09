# Social_security_modelling

##Scraping data from the DWP tabulation tool
Allows time series data for any two variables in the DWP tabulation tool to be scraped into R.

##Extracting information on caseloads for particular variables from average weekly benefits.
The DWP tabulation is limited to displaying four variables at once - a row, a column, and date and one other filter. For example, you can have the sex of the claimant as the rows, the age as the columns, and the region filtered to just Scotland. However, there are a lot of instances where we'd like to break it down further than that.

We can add additional information about the proportion claiming different benefit rates by looking at the average weekly benefit. For example, for attendance allowance there are two rates - higher and lower. Since we know what the rates are, we can calculate the proportion on each rate from the average weekly benefit, and thus the number on each rate from the overall caseload.
