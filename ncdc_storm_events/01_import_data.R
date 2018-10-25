#' @author Tim Trice <tim.trice@gmail.com>
#' @description Import NCDC Storm Events Database
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

# ---- fips ----
#' source https://www.census.gov/geo/reference/codes/cou.html
#' FIPS Class Codes
#' - H1: identifies an active county or statistically equivalent entity that
#'   does not qualify under subclass C7 or H6.
#' - H4: identifies a legally defined inactive or nonfunctioning county or
#'     statistically equivalent entity that does not qualify under subclass H6.
#' - H5:  identifies census areas in Alaska, a statistical county equivalent
#'     entity.
#' - H6: identifies a county or statistically equivalent entity that is areally
#'     coextensive or governmentally consolidated with an incorporated place,
#'     part of an incorporated place, or a consolidated city.
#' - C7: identifies an incorporated place that is an independent city; that is,
#'     it also serves as a county equivalent because it is not part of any
#'     county, and a minor civil division (MCD) equivalent because it is not
#'     part of any MCD.

domain <- "https://www2.census.gov/geo/docs/reference/codes/files/"

urls <-
  list(
    "US" = "national_county.txt",
    "American Samoa" = "st60_as_cou.txt",
    "Guam" = "st66_gu_cou.txt",
    "Northern Mariana Islands" = "st69_mp_cou.txt",
    "Puerto Rico" = "st72_pr_cou.txt",
    "US Minor Outlying Islands" = "st74_um_cou.txt",
    "US Virgin Islands" = "st78_vi_cou.txt"
  )

#' FIPS column names are different than those used in `df$details`; to help with
#' joins and other statements, I'm going to rename them on import. They are,
#' - STATE_FIPS = STATEFP
#' - CZ_FIPS = COUNTYFP
#' - CZ_NAME = COUNTYNAME

columns <- c("STATE", "STATE_FIPS", "CZ_FIPS", "CZ_NAME", "CLASSFP")

column_classes <- cols(
  "STATE" = col_character(),
  "STATE_FIPS" = col_integer(),
  "CZ_FIPS" = col_integer(),
  "CZ_NAME" = col_character(),
  "CLASSFP" = col_character()
)

#' Occasionally this may start generating a "HTTP error 304"; this seems to be
#' if too many requests are within a short time period, but I haven't verified
#' this.
fips <-
  map_df(
    .x = urls,
    .f = ~read_csv(
      glue("{domain}{.x}"),
      col_names = columns,
      col_types = column_classes
    )
  ) %>%
  distinct() %>%
  write_csv(path = here("./ncdc_storm_events/fips.csv"))

# ---- save-data ----
save(df, file = here("./ncdc_storm_events/01_ncdc_storm_events.RData"))
