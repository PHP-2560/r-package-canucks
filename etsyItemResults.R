#'
#' Function to obtain the names of the items returned from an Etsy.com search. 
#'
#' This function obtains the names of the items returned from an Etsy.com search by reading
#' the scraped xml.  
#'
#' @param results_xml An xml object, obtained from scraping an Etsy search results webpage. 
#' \emph{Note: The xml is easily obtained using the etsyURL() and etsyXML() functions.} 
#'
#' @keywords url
#'
#' @return Returns an Etsy.com URL.
#'
#' @examples
#' etsyURL("knitted scarf")
#' etsyURL("welcome sign", "date_desc")
#'
#' @export
#' 

# etsyGetItems scrapes the names of the items that return from etsy.com search 
# by extracting them from the read_html of the results page
etsyItemResults <- function(results_xml) {
  items <- trimws(html_text(html_nodes(results_xml, ".text-body")), which = "both")
  return(items)
}