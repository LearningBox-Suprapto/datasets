#' @title write_data
#' @author Tim Trice
#' @description Write HURDAT data to CSV
#' @details Write the discus, fstadv, posest, prblty, public, update and wndprb
#' datasets to CSV and SQL.

# ---- libraries ----
library(glue)
library(here)
library(HURDAT)
library(readr)

# ---- settings ----
datasets <- c("AL", "EP")

# ---- data ----
data(list = datasets)

# Write CSV
walk(datasets, ~write_csv(get(.x), path = glue(here("./HURDAT/{.x}.csv"))))
