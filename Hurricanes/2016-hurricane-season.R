library(Hurricanes)

storms.2016 <- get_storms(2016)
get_storm_data("fstadv", 
               link = storms.2016 %>% 
                 .$Link, 
               display_link = FALSE)
write.csv(fstadv, file = "2016-hurricane-season.csv", row.names = FALSE)