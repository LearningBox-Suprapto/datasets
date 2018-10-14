# ---- libraries ----
library(dplyr)
library(glue)
library(lubridate)
#' Load after `lubridate` so `here::here` is not masked behind `lubridate::here`
library(here)
library(purrr)
library(stringr)
library(tidyr)

# ---- data ----
load(file = "data.RData")

# ---- functions ----
#' @title var_conversion
#' @description Test variables in dataframe and convert, without error, to
#'   integer, double, or leave as character.
#' @param x Variable to test
var_conversion <- function(x) {

  quietly_as_integer <- quietly(.f = as.integer)
  quietly_as_double <- quietly(.f = as.double)

  y <- quietly_as_integer(x)
  z <- quietly_as_double(x)

  if (all(y$result == z$result) & !is.na(all(y$result == z$result)))
    return(y$result)

  if (all(is_empty(z$warnings), is_empty(z$messages)))
    return(z$result)

  return(x)
}

# ---- convert-columns ----
df <- map(df, mutate_all, .funs = var_conversion)

# ---- details-dates ----
#' Add a proper date time for beginning and end
df$details <-
  df$details %>%
  mutate(
    NEW_BEGIN_DATE_TIME = ymd_hms(
      glue("
        {YEAR}-\\
        {MONTH_NAME}-\\
        {BEGIN_DAY} \\
        {hour(dmy_hms(BEGIN_DATE_TIME))}: \\
        {minute(dmy_hms(BEGIN_DATE_TIME))}: \\
        {second(dmy_hms(BEGIN_DATE_TIME))}
      ")
    ),
    NEW_END_DATE_TIME = ymd_hms(
      glue("
        {YEAR}-\\
        {MONTH_NAME}-\\
        {END_DAY} \\
        {hour(dmy_hms(END_DATE_TIME))}: \\
        {minute(dmy_hms(END_DATE_TIME))}: \\
        {second(dmy_hms(END_DATE_TIME))}
      ")
    )
  )

#' Drop old vars and rename new vars
df$details <-
  df$details %>%
  select(-c(
    BEGIN_YEARMONTH, BEGIN_DAY, BEGIN_TIME, END_YEARMONTH, END_DAY, END_TIME,
    YEAR, MONTH_NAME, BEGIN_DATE_TIME, END_DATE_TIME
  )) %>%
  rename(
    BEGIN_DATE_TIME = NEW_BEGIN_DATE_TIME,
    END_DATE_TIME = NEW_END_DATE_TIME
  )
