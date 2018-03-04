#+ libraries
library(bigrquery)
library(DBI)
library(glue)
library(magrittr)
library(readr)

#+ options
# Disable interactive request
options("httr_oauth_cache" = "~/.httr-oauth")

#+ connect-bigquery
bigquery <- dbConnect(bigrquery::dbi_driver(),
                      project = Sys.getenv("bq.project"),
                      dataset = "samples",
                      use_legacy_sql = FALSE)

#+ query
sql <- readLines("./stackoverflow/r-version-change-over-time.sql") %>%
  collapse(sep = "\n")

#+ results
df <- dbSendQuery(bigquery, sql) %>%
  dbFetch()

#+ disconnect-bigquery
dbDisconnect(bigquery)

#+ save-data
write_csv(df, "./stackoverflow/r-version-change-over-time.csv")
