library(purrr)
#Things we need:
#Directly forecast caseloads
#Directly forecast inflows
#Directly forecast outflows
#Directly forecast onflows
#Directly forecast inflow_rates
#Directly forecast outflow_rates
#Directly forecast onflow_rates

#Calculate caseloads from in+out+onflows
#Calculate inflow from population and inflow_rate
#Calculate out/onflow from caseloads and out/onflow rate

#Example workflow:
##Forecast in+out+onflow rates

forecast_rates = function(age_ranges, start_date, end_date, rate="inflow"){
  dates = seq(start_date,end_date)
  
  map(age_ranges,~forecast_for_range(.,dates)) %>%
    set_names(age_ranges) %>%
    as_tibble() %>%
    mutate(date = dates) %>%
    gather(age_range,inflow_rate,-date) %>%
    return()
}

forecast_for_range = function(age_range,dates){
  return(rep(0.005,NROW(dates)))
}
##Add population forecasts
##Calculate inflow forecasts from inflow_rate and population forecasts