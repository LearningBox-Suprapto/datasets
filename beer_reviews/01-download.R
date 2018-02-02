#~/usr/bin/Rscript

#' Data courtesy of Beer Advocate <http://www.beeradvocate.com>

## ---- Libraries ----
library(DBI)

## ---- Variables ----
#' IP Address to Postgres database
ip <- NULL

## ---- Data ----

## ---- * Download ----
url <- "https://s3.amazonaws.com/demo-datasets/beer_reviews.tar.gz?lipi=urn%3Ali%3Apage%3Ad_flagship3_pulse_read%3B%2BTvuRj%2B2RxyosCECk8fxgQ%3D%3D"
utils::download.file(file.path(url), zip_file <- tempfile())
utils::untar(zip_file, exdir = ".")
