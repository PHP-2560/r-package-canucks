
# unused function - getting star rating for each shop
etsyShopRatings <- function(results_xml) {
  ratings <- vector(length = 0)
  
  for (i in 1:length(html_nodes(results_xml, ".stars-svg.stars-smaller"))) {
    rating <- xml_attrs(xml_child(html_nodes(results_xml, ".stars-svg.stars-smaller")[[i]],1))[["value"]]
    ratings <- c(ratings, rating)
  }
  return(ratings)
}
