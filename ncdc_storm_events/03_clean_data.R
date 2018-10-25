#' @author Tim Trice <tim.trice@gmail.com>
#' @description Clean NCDC Storm Events Database
#' @source https://www.ncdc.noaa.gov/stormevents/

# ---- libraries ----
library(tidyverse)

# ---- sources ----
source(here::here("./ncdc_storm_events/functions.R"))

# ---- data ----
load(file = here::here("./ncdc_storm_events/02_ncdc_storm_events.RData"))

# ---- event-type ----
#' Clean; source: http://www.nws.noaa.gov/directives/sym/pd01016005curr.pdf

df$details <- mutate_at(df$details, "EVENT_TYPE", .funs = str_to_title)

df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Hail Flooding"] <- "Hail, Flooding"
#' There is no "Icy Roads" entry
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Hail/Icy Roads"] <- "Hail"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "High Snow"] <- "Heavy Snow"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Hurricane"] <- "Hurricane (Typhoon)"
#' Allow "landslide" though it is not in the list.
#' Allow "northern lights" though not on list and honeslty, I want to see what this is
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Sneakerwave"] <- "Sneaker Wave"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Wind/ Tree"] <- "Thunderstorm Wind"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Wind/ Trees"] <- "Thunderstorm Wind"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Winds Funnel Clou"] <- "Thunderstorm Wind, Funnel Cloud"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Winds Heavy Rain"] <- "Thunderstorm Wind, Heavy Rain"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Winds Lightning"] <- "Thunderstorm Wind, Lightning"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Winds/ Flood"] <- "Thunderstorm Wind, Flood"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Winds/Flash Flood"] <- "Thunderstorm Wind, Flash Flood"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Winds/Flooding"] <- "Thunderstorm Wind, Flood"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Thunderstorm Winds/Heavy Rain"] <- "Thunderstorm Wind, Heavy Rain"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Tornado/Waterspout"] <- "Tornado, Waterspout"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Tornadoes, Tstm Wind, Hail"] <- "Tornado, Thunderstorm Wind, Hail"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Volcanic Ashfall"] <- "Volcanic Ash"
df$details$EVENT_TYPE[df$details$EVENT_TYPE == "Other"] <- NA_character_

# ---- cz-type ----
#' There are 23 values of "2" for `CZ_TYPE`; however, when examining the variables
#' `CZ_TYPE`, `CZ_FIPS`, and `CZ_NAME`, there are not clear distinctions as to
#' what the correct value should be. Every entry where `CZ_TYPE` is 2 also has
#' at least one observation with value of "C" and a value of "Z". Therefore, I
#' cannot safely conclude these 23 should be one or another. Because of this,
#' will make NA.
df$details$CZ_TYPE[df$details$CZ_TYPE == 2] <- NA_character_

# ---- state ----
#' We can safely cross reference `fips$STATE`
df$details$STATE <- NULL

# ---- cz-fips ----
#' There are 1667 records in `df$details$CZ_FIPS` that equal int 0; 0 is not a
#' valid CZ_FIP; make NA.
df$details$CZ_FIPS[df$details$CZ_FIPS == 0] <- NA_integer_

# ---- cz-timezone ----
#' Remove CZ_TIMEZONE; wildly inaccurate. This means `BEGIN_DATE_TIME` and
#' `END_DATE_TIME` which both have timezone stamps must be corrected.
df$details$CZ_TIMEZONE <- NULL

# ---- save-data ----
walk(names(df), ~write_csv(x = get(df[[.x]]), path = glue(here::here("./ncdc_storm_events/{.x}.csv"))))
