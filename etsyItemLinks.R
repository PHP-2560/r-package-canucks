
# etsyGetLinks scrapes the link to each item returned by the research results
etsyItemLinks <- function(results_xml) {
  num_items <- length(etsyGetItems(results_xml))
  links <- vector(length = 0)
  
  for (i in 1:num_items) {
    links <- c(links, (html_attr(xml_child(xml_child(html_nodes(results_xml, ".block-grid-item")[[i]],1),1), "href")))
  }
  return(links)
}
