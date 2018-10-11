#' @title ncdc_storm_events
#' @author Tim Trice <tim.trice@gmail.com>
#' @description Gather and clean csv.gz datasets from the NCDC Storm Events
#'   Database. Build three tables; details, fatalities and locations
#' @source https://www.ncdc.noaa.gov/stormevents/

## Libraries ----
library(curl)
library(glue)
library(janitor)
library(tidyverse)
library(XML)

## Options ----
#' NA

## Settings ----
# ---- ftp ----
#' FTP URL
ftp <- "ftp://ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/"

# ---- tables ----
#' Three datasets we'll be obtaining
tables <- c("details", "fatalities", "locations")
#' Expected col_types per dataset.
table_col_types <- list(
  "details" = glue_collapse(rep("c", 51L)),
  "fatalities" = glue_collapse(rep("c", 11L)),
  "locations" = glue_collapse(rep("c", 11L))
)

## Functions ----
#' NA

## Import Data ----

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
    .x = glue("^StormEvents_{tables}"),
    .f = grep,
    x = tbl$V9,
    value = TRUE
  ) %>%
  set_names(nm = tables)

# ---- load_details ----
#' Get the details dataset (this can take a while)
details <-
  map_df(
    .x = glue("{ftp}{by_table$details}"),
    .f = read_csv,
    #' Make character to avoid reading errors or warnings
    col_types = table_col_types$details,
    progress = TRUE
  )

write_csv(details, path = "./ncdc_storm_events/details.csv")

# ---- load_fatalities ----
#' ...fatalities (can take a while, too)...
fatalities <-
  map_df(
    .x = glue("{ftp}{by_table$fatalities}"),
    .f = read_csv,
    #' Make character to avoid reading errors or warnings
    col_types = table_col_types$fatalities,
    progress = TRUE
  )

write_csv(fatalities, path = "./ncdc_storm_events/fatalities.csv")

# ---- load_locations ----
#' ...and locations (a bit faster.
locations <-
  map_df(
    .x = glue("{ftp}{by_table$locations}"),
    .f = read_csv,
    #' Make character to avoid reading errors or warnings
    col_types = table_col_types$locations,
    progress = TRUE
  )

write_csv(locations, path = "./ncdc_storm_events/locations.csv")
