library(tidyverse)
library(lubridate)
library(rvest)

scrape_page = function(url) {
  data = read_html(url)
  scraped = data %>% html_nodes("td.r.b.data") %>% html_text() %>% as.numeric()
  if(length(scraped) == 0) {
    scraped = data %>% html_nodes("td.r.b.Data") %>% html_text() %>% as.numeric()
  }
  return(scraped)
}

generate_url = function(quarter) {
  url_template = "http://tabulation-tool.dwp.gov.uk/100pc/aa_ent/ccsex/ccaaawd/ccgor/a_carate_r_ccsex_c_ccaaawd_p_ccgor_scotland_%s.html"
  return(sprintf(url_template, quarter))
}

scrape_quarter = function(quarter) {
  return(quarter %>% generate_url %>% scrape_page)
}

dates_to_quarters = function(dates) {
  return(dates %>% format("%b%y"))
}

get_time_series = function() {
  dates = ymd("2002-05-01") %m+% months(seq(from = 0, to = 165, by = 3))
  dates %>%
    dates_to_quarters() %>%
    sapply(scrape_quarter) %>%
    as_tibble() %>%
    return()
}