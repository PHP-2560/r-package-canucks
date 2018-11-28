
library(rvest)
library(tidyverse)

# etsyGetShops scrapes the names of the shops from the results of the etsy.com search
# by extracting the names from the results page read_html
etsyShopResults <- function(results_xml) {
  shops <- trimws(html_text(html_nodes(results_xml, "p.text-gray-lighter")), which = "both")
  return(shops)
}