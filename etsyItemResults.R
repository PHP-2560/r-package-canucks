
library(rvest)
library(tidyverse)

# etsyGetItems scrapes the names of the items that return from etsy.com search 
# by extracting them from the read_html of the results page
etsyItemResults <- function(results_xml) {
  items <- trimws(html_text(html_nodes(results_xml, ".text-body")), which = "both")
  return(items)
}