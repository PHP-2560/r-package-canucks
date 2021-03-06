% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/etsyShopReviews.R
\name{etsyShopReviews}
\alias{etsyShopReviews}
\title{Function to obtain the customer text-based reviews of each shop selling an item returned by an Etsy.com search.}
\usage{
etsyShopReviews(results_xml)
}
\arguments{
\item{results_xml}{An xml object, obtained from scraping an Etsy search results webpage}
}
\value{
Returns a character vector of paragraphs representing the reviews from each individual shop.
}
\description{
This function scrapes the customer reviews of each Etsy shop.
\itemize{
  \item Utilizes the etsyShopResults() function to extract the name of each Etsy shop from the
  Etsy.com search results.
  \item Creates a URL for each individual shop, and scrapes the shop URL for the shop reviews.
  \item Collapses each individual review from the first page of the shop's reviews (only)
  into one text paragraph.
}
}
\keyword{html}
\keyword{reviews}
\keyword{shop}
\keyword{xml}
