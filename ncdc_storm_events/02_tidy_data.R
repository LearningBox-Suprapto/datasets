# ---- libraries ----
library(dplyr)
library(glue)
library(lubridate)
#' Load after `lubridate` so `here::here` is not masked behind `lubridate::here`
library(here)
library(purrr)
library(stringr)
library(tidyr)

# ---- sources ----
source(here("./ncdc_storm_events/functions.R"))

# ---- data ----
load(file = here("./ncdc_storm_events/ncdc_storm_events.RData"))

# ---- convert-columns ----
df <- map(df, mutate_all, .funs = var_conversion)

# ---- details-dates ----
#' Add a proper date time for beginning and end
df$details <-
  df$details %>%
  mutate(
    BEGIN_DATE_TIME = ymd_hms(
      glue("
        {YEAR}-\\
        {MONTH_NAME}-\\
        {BEGIN_DAY} \\
        {hour(dmy_hms(BEGIN_DATE_TIME))}: \\
        {minute(dmy_hms(BEGIN_DATE_TIME))}: \\
        {second(dmy_hms(BEGIN_DATE_TIME))}
      ")
    ),
    END_DATE_TIME = ymd_hms(
      glue("
        {YEAR}-\\
        {MONTH_NAME}-\\
        {END_DAY} \\
        {hour(dmy_hms(END_DATE_TIME))}: \\
        {minute(dmy_hms(END_DATE_TIME))}: \\
        {second(dmy_hms(END_DATE_TIME))}
      ")
    )
  ) %>%
  select(-c(
    BEGIN_YEARMONTH, BEGIN_DAY, BEGIN_TIME, END_YEARMONTH, END_DAY, END_TIME,
    YEAR, MONTH_NAME
  ))

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

# ---- fatalities-dates ----
df$fatalities <-
  df$fatalities %>%
  mutate(FATALITY_DATE = mdy_hms(FATALITY_DATE)) %>%
  select(-c(FAT_YEARMONTH, FAT_DAY, FAT_TIME, EVENT_YEARMONTH))

# ---- locations-yearmonth ----
#' Drop `YEARMONTH`; is redundant (in `details`)
df$locations$YEARMONTH <- NULL
