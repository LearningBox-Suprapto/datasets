#~/usr/bin/Rscript

#' Data courtesy of Beer Advocate <http://www.beeradvocate.com>

url <- "https://s3.amazonaws.com/demo-datasets/beer_reviews.tar.gz?lipi=urn%3Ali%3Apage%3Ad_flagship3_pulse_read%3B%2BTvuRj%2B2RxyosCECk8fxgQ%3D%3D"

utils::download.file(file.path(url), destfile = "beer_reviews.tar.gz")

