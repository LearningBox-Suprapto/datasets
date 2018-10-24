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

