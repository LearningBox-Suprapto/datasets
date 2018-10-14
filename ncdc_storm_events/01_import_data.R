#' @title ncdc_storm_events
#' @author Tim Trice <tim.trice@gmail.com>
#' @description Gather and clean csv.gz datasets from the NCDC Storm Events
#'   Database. Build three tables; details, fatalities and locations
#' @source https://www.ncdc.noaa.gov/stormevents/

# ---- libraries ----
library(curl)
library(glue)
library(here)
library(purrr)
library(readr)

# ---- sources ----
source(here("./ncdc_storm_events/functions.R"))

# ---- options ----
#' NA

# ---- settings ----
#' FTP URL
ftp <- "ftp://ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/"

#' Three datasets we'll be obtaining
tables <- list(
  "details" = 51L,
  "fatalities" = 11L,
  "locations" = 11L
)

# ---- connection ----
#' Establish connection, get list of gz datasets
con = curl(ftp, "r")
tbl = read.table(con, stringsAsFactors = TRUE, fill = TRUE)
close(con)

# ---- by_table ----
#' Split out the datasets into their own lists. Will end up with a list of
#' length 3 for each table containing all related dataset URLs
by_table <-
  map(
    .x = glue("^StormEvents_{names(tables)}"),
    .f = grep,
    x = tbl$V9,
    value = TRUE
  ) %>%
  set_names(nm = names(tables))

# ---- load-data ----
df <-
  map2(
    .x = names(tables),
    .y = flatten_int(tables),
    .f = import_datasets
  ) %>%
  set_names(nm = names(tables))

# ---- save-data ----
save(df, file = here("./ncdc_storm_events/ncdc_storm_events.RData"))
