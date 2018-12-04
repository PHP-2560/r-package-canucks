#'
#' Function to obtain shop name.
#'
#' @param results_xml An xml object, obtained from scraping an Etsy search results webpage.
#'
#' @keywords html
#' @keywords xml
#' @keywords shops
#'
#' @return Returns the shop name as a character vector.
#'
#' @example
#' etsyShopResults(results_xml)
#'
#' @export


etsyShopResults <- function(results_xml) {
  shops <- trimws(rvest::html_text(rvest::html_nodes(results_xml, "p.text-gray-lighter")), which = "both")
  return(shops)
}
