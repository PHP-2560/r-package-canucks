#'
#' Function to obtain shop reviews.
#'
#' This function scrapes the text-based customer reviews of each shop resulting from the etsy.com search
#' The function uses the etsyGetShops function to extract the names of the relevent etsy shops.
#' It then creates a url for each individual shop, and scrapes that URL for the shop reviews.
#' The function collapses all the different reviews on the first page (only) of the shop's review url into one text paragraph,
#' and returns a vector of paragraphs representing the reviews from each shop.
#'
#' @param results_xml An xml object, obtained from scraping an Etsy search results webpage
#'
#'
#' @keywords html
#' @keywords xml
#' @keywords reviews
#'
#' @return Returns the shop reviews as a character vector.
#'
#' @example
#' etsyShopReviews(results_xml)
#'
#' @export

etsyShopReviews <- function(results_xml) {
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
