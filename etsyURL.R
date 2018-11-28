
library(rvest)
library(tidyverse)

# etsyURL function creates the etsy.com url based on the user's search string
etsyURL <- function(search_string, search_order='most_relevant') {
  base_url='https://www.etsy.com/search?q='
  search_string <- gsub(' ', '+', search_string, fixed = TRUE)
  # Other search options -- most recent: date_desc, highest price: price_desc, lowest price: price_asc.
  search_order <- paste0('&explicit=1&order=', search_order)
  url <- paste0(base_url, search_string, search_order)
  return(url)
}