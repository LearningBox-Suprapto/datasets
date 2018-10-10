library(curl)
library(glue)
library(janitor)
library(tidyverse)
library(XML)

#' Establish connection, get list of datasets
ftp <- "ftp://ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/"
con = curl(ftp, "r")
tbl = read.table(con, stringsAsFactors = TRUE, fill = TRUE)
close(con)

#' Three datasets we'll be obtianing
classes <- c("details", "fatalities", "locations")

#' Split out the datasets into their own lists
by_class <-
  map(
    .x = glue("^StormEvents_{classes}"),
    .f = grep,
    x = tbl$V9,
    value = TRUE
  ) %>%
  set_names(nm = classes)

class_col_types <- list(
  "details" = glue_collapse(rep("c", 51L)),
  "fatalities" = glue_collapse(rep("c", 11L)),
  "locations" = glue_collapse(rep("c", 15L))
)

#' Get the details dataset (this can take a while)
names_details <-
  read_csv(
    file = glue("{ftp}{by_class$details}")[1],
    col_names = FALSE,
    n_max = 1L,
    col_types = class_col_types$details
  ) %>%
  as_vector() %>%
  clean_names() %>%
  str_to_lower()

details <-
  map_df(
    .x = glue("{ftp}{by_class$details}"),
    .f = read_csv,
    col_names = names_details,
    skip = 1L,
    #' Make character to avoid reading errors or warnings
    col_types = class_col_types$details,
    progress = TRUE
  )

save(details, file = file.path(dp, "details.rda"))

#' ...fatalities (can take a while, too)...
names_fatalities <-
  read_csv(
    file = glue("{ftp}{by_class$fatalities}")[1],
    col_names = FALSE,
    n_max = 1L,
    col_types = class_col_types$fatalities
  ) %>%
  as_vector() %>%
  clean_names() %>%
  str_to_lower()

fatalities <-
  map_df(
    .x = glue("{ftp}{by_class$fatalities}"),
    .f = read_csv,
    col_names = names_fatalities,
    skip = 1L,
    #' Make character to avoid reading errors or warnings
    col_types = glue_collapse(rep("c", 11L)),
    progress = TRUE
  )

save(fatalities, file = file.path(dp, "fatalities.rda"))

#' ...and locations (a bit faster.
names_locations <-
  read_csv(
    file = glue("{ftp}{by_class$locations}")[1],
    col_names = FALSE,
    n_max = 1L,
    col_types = class_col_types$locations
  ) %>%
  as_vector() %>%
  clean_names() %>%
  str_to_lower()

locations <-
  map_df(
    .x = glue("{ftp}{by_class$locations}"),
    .f = read_csv,
    col_names = names_locations,
    skip = 1L,
    #' Make character to avoid reading errors or warnings
    col_types = glue_collapse(rep("c", 15L)),
    progress = TRUE
  )

save(locations, file = file.path(dp, "locations.rda"))
