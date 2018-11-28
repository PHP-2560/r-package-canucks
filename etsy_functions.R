
library(rvest)
library(tidyverse)

# etsyURL function creates the etsy.com url based on the user's search string
etsyURL <- function(search_string, search_order='most_relevant') {
  base_url='https://www.etsy.com/search?q='
  search_string <- gsub(' ', '+', search_string, fixed = TRUE)
  # Other search options: - most recent: date_desc, highest price: price_desc, lowest price: price_asc.
  search_order <- paste0('&explicit=1&order=', search_order)
  url <- paste0(base_url, search_string, search_order)
  return(url)
}

# etsyGetItems scrapes the names of the items that return from etsy.com search 
# by extracting them from the read_html of the results page
etsyGetItems <- function(results_xml) {
  items <- trimws(html_text(html_nodes(results_xml, ".text-body")), which = "both")
  return(items)
}

# etsyGetShops scrapes the names of the shops from the results of the etsy.com search
# by extracting the names from the results page read_html
etsyGetShops <- function(results_xml) {
  shops <- trimws(html_text(html_nodes(results_xml, "p.text-gray-lighter")), which = "both")
  return(shops)
}

# etsyGetShopReviews scrapes the text-based customer reviews of each shop resulting from the etsy.com search
# The function uses the etsyGetShops function to extract the names of the relevent etsy shops.
# It then creates a url for each individual shop, and scrapes that URL for the shop reviews. 
# The function collapses all the different reviews on the first page (only) of the shop's review url into one text paragraph,
# and returns a vector of paragraphs representing the reviews from each shop. 
etsyGetShopReviews <- function(results_xml) {
  shop <- etsyGetShops(results_xml)
  reviews <- vector(length = 0)
  
  for (i in 1:length(shop)) {
    reviews_url <- paste("https://www.etsy.com/shop/", shop[i], "/reviews", sep="")
    page <- read_html(reviews_url)
    review_text <- paste(html_text(html_nodes(page, ".m-xs-0")), collapse = " ", sep=" ")
    reviews <- c(reviews, review_text)
  }
  return(reviews)
}

# etsyGetShopLocations scrapes the location of each etsy shop as listed on the shop's webpage
# The function uses the etsyGetShops function to extract the names of the relevent etsy shops.
# It then creates a url for each individual shop, and scrapes that URL for the shop location. 
# The function returns the shop locations in a vector. 
etsyGetShopLocations <- function(results_xml) {
  shop <- etsyGetShops(results_xml)
  locations <- vector(length = 0)
  
  for (i in 1:length(shop)) {
    location_url <- paste("https://www.etsy.com/shop/", shop[i], sep="")
    location_page <- read_html(location_url)
    
    location <- trimws(html_text(html_nodes(location_page, ".shop-location")), which = "both")[1]
    locations <- c(locations, location)
  }
  return(locations)
}

# etsyGetLinks scrapes the link to each item returned by the research results
etsyGetLinks <- function(results_xml) {
  num_items <- length(etsyGetItems(results_xml))
  links <- vector(length = 0)
  
  for (i in 1:num_items) {
    links <- c(links, (html_attr(xml_child(xml_child(html_nodes(results_xml, ".block-grid-item")[[i]],1),1), "href")))
  }
  return(links)
}

# unused function - getting star rating for each shop
etsyGetRatings <- function(results_xml) {
  ratings <- vector(length = 0)
  
  for (i in 1:length(html_nodes(results_xml, ".stars-svg.stars-smaller"))) {
    rating <- xml_attrs(xml_child(html_nodes(results_xml, ".stars-svg.stars-smaller")[[i]],1))[["value"]]
    ratings <- c(ratings, rating)
  }
  return(ratings)
}

