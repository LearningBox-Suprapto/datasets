#' @author Tim Trice <tim.trice@gmail.com>
#' @description Tidy NCDC Storm Events Database
#' @source https://www.ncdc.noaa.gov/stormevents/
#' @details
#'   1.In this script, I use `here::here` rather than load it due to the use
#'     of `lubridate::here`; it can create "unused argument" errors; so I just
#'     decided to make direct calls to the namespace.

# ---- libraries ----
library(dplyr)
library(glue)
library(lubridate)      #' See @details #1
library(purrr)
library(stringr)
library(tidyr)

# ---- sources ----
source(here::here("./ncdc_storm_events/functions.R"))

# ---- data ----
load(file = here::here("./ncdc_storm_events/01_ncdc_storm_events.RData"))

# ---- convert-columns ----
df <- map(df, .f = mutate_all, .funs = var_conversion)

# ---- details-dates ----
#' Add a proper date time for beginning and end dates/times
#' 2018-10-25 - Resolves GH Issue #2
df$details <-
  df$details %>%
  mutate_at(
    .vars = vars("BEGIN_DATE_TIME", "END_DATE_TIME"),
    .funs = parse_date_time2,
    orders = "%d!-%m!-%y!* %H!:%M!:%S!",
    cutoff_2000 = 19L
  ) %>%
  select(
    -c(
      BEGIN_YEARMONTH, BEGIN_DAY, BEGIN_TIME, END_YEARMONTH, END_DAY, END_TIME,
      YEAR, MONTH_NAME
    )
  ) %>%
  #' Make character string; timezones are invalid and junk.
  mutate_at(
    .vars = vars("BEGIN_DATE_TIME", "END_DATE_TIME"),
    .funs = as.character,
  )

# ---- details-damage ----
df$details <-
  df$details %>%
  extract(
    col = DAMAGE_PROPERTY,
    into = c("DAMAGE_PROPERTY_VALUE", "DAMAGE_PROPERTY_KEY"),
    regex = "([[:digit:]\\.]+)([[:alpha:]])*",
    remove = FALSE,
    convert = TRUE
  ) %>%
  extract(
    col = DAMAGE_CROPS,
    into = c("DAMAGE_CROPS_VALUE", "DAMAGE_CROPS_KEY"),
    regex = "([[:digit:]\\.]+)([[:alpha:]])*",
    remove = FALSE,
    convert = TRUE
  ) %>%
  mutate_at(
    .vars = vars(c(DAMAGE_PROPERTY_KEY, DAMAGE_CROPS_KEY)),
    .funs = ~case_when(
      .x %in% c("h", "H") ~ 1e2,
      .x %in% c("k", "K") ~ 1e3,
      .x %in% c("m", "M") ~ 1e6,
      .x %in% c("b", "B") ~ 1e9,
      TRUE                ~ 1
    )
  ) %>%
  mutate(
    DAMAGE_PROPERTY = DAMAGE_PROPERTY_VALUE * DAMAGE_PROPERTY_KEY,
    DAMAGE_CROPS = DAMAGE_CROPS_VALUE * DAMAGE_CROPS_KEY
  ) %>%
  select(-c(
    DAMAGE_PROPERTY_VALUE, DAMAGE_PROPERTY_KEY, DAMAGE_CROPS_VALUE,
    DAMAGE_CROPS_KEY
  ))

# ---- state-fips ----
#' Can safely drop `STATE` from `details`
df$details$STATE <- NULL

# ---- fatalities-dates ----
df$fatalities <-
  df$fatalities %>%
  mutate(FATALITY_DATE = mdy_hms(FATALITY_DATE)) %>%
  select(-c(FAT_YEARMONTH, FAT_DAY, FAT_TIME, EVENT_YEARMONTH))

# ---- locations-yearmonth ----
#' Drop `YEARMONTH`; is redundant (in `details`)
df$locations$YEARMONTH <- NULL

# ---- save-data ----
save(
  list = objects(),
  file = here::here("./ncdc_storm_events/02_ncdc_storm_events.RData")
)
