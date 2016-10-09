library(tidyverse)
library(lubridate)
library(rvest)
library(stringr)

scrape_page = function(url) {
  print(url)
  data = read_html(url)
  scraped = data %>% html_nodes("td.r.b.data") %>% html_text() %>% as.numeric()
  if(length(scraped) == 0) {
    scraped = data %>% html_nodes("td.r.b.Data") %>% html_text() %>% as.numeric()
  }
  return(scraped)
}

get_column_headers = function(url_minus_date) {
  url_minus_date %>%
    sprintf("May02") %>%
    read_html() %>%
    html_nodes(xpath = "//html//body//div[2]//table//thead//tr[2]//th") %>%
    html_text(trim = TRUE) %>%
    str_replace_all(" ","_")
}

get_row_headers = function(url_minus_date) {
  (url_minus_date %>%
    sprintf("May02") %>%
    read_html() %>%
    html_nodes(xpath = "//html//body//div[2]//table//tbody//tr//th") %>%
    html_text(trim = TRUE) %>%
    str_replace_all(" ","_")
  )[-2:-1]
}

generate_url = function(quarter, url_minus_date) {
  url_minus_date %>% sprintf(quarter) %>% return()
}

format_dates = function(dates) {
  return(dates %>% format("%b%y") %>% purrr::set_names())
}

get_time_series = function(benefit, analysis, row, column, subset_on, subset = NULL) {
  url_template = "http://tabulation-tool.dwp.gov.uk/100pc/%1$s/%3$s/%4$s/%5$s/a_%2$s_r_%3$s_c_%4$s_p_%5$s_%6$s_%%s.html"
  url_minus_date = url_template %>% sprintf(benefit, analysis, row, column, subset_on, subset)
  row_headers = get_row_headers(url_minus_date)
  column_headers = get_column_headers(url_minus_date)
  dates = ymd("2002-05-01") %m+% months(seq(from = 0, to = 165, by = 3))
  dates %>%
    format_dates() %>%
    map_df(~generate_url(., url_minus_date) %>% scrape_page()) %>%
    as_tibble() %>%
    #mutate_(row = c(rep("Female", 3), rep("Male", 3)), column = rep(column_headers, length(row_headers))) %>%
    #gather(date, caseload, -gender, -rate) %>%
    return()
}