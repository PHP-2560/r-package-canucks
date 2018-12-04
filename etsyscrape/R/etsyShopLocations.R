#'
#' Function to obtain shop location.
#'
#' etsyShopLocations scrapes the location of each etsy shop as listed on the shop's webpage
#' The function uses the etsyGetShops function to extract the names of the relevent etsy shops.
#' It then creates a url for each individual shop, and scrapes that URL for the shop location. 
#' The function returns the shop locations in a vector.
#'
#' @param results_xml An xml object, obtained from scraping an Etsy search results webpage.
#'
#' @keywords html
#' @keywords xml
#' @keywords location
#'
#' @return Returns the shop location as a character vector. 
#'
#' @example 
#' etsyShopLocations(results_xml)
#'
#' @export 

etsyShopLocations <- function(results_xml) {
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