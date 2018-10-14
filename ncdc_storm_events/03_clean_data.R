#' @author Tim Trice <tim.trice@gmail.com>
#' @description Clean NCDC Storm Events Database
#' @source https://www.ncdc.noaa.gov/stormevents/

# ---- libraries ----
library(here)

# ---- sources ----
source(here("./ncdc_storm_events/functions.R"))

# ---- data ----
load(file = here("./ncdc_storm_events/02_ncdc_storm_events.RData"))
