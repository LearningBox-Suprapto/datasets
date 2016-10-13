This dataset is a collection of "real-time" data as obtained from the National Hurricane Center archives. It will be updated as time goes on. 

This data is collected using the R library Hurricanes which I am working on; still beta. It accesses the text products for every advisory issued and posted in the NHC archives. There is no guarantee the data is 100% correct. But some analysis does indicate it is at least 95% (estimate). 

## Codebook

Key, Adv and ObDate are the foreign keys relating each dataset to one another. Do not rely on Name as Name may change if the system goes from unnmaed (tropical depression) to named (tropical storm). Adv and ObDate should be used in conjunction as there is a possibility, though I haven't seen it yet, that a storm may have the same advisory number but different observation times; e.g., if a correction is issued or new data is obtained after an original issue.

`advisories`

 * Key alphanumeric 8-digit string uniquely identifying each storm
 * Name alpha string given to each storm. 
 * ObDate POSIXct date/time in UTC
 * Status classification of the storm as listed in the text header
 * Lat latitude of location, positive is N, negative is S hemisphere
 * Lon longitude, positive is E, negative is W
 * Wind wind speed in knots
 * Gust maximum gust in knots
 * Pressure central pressure in millibars
 * PosAcc position accuracy of the storm in nautical miles
 * FwdDir forward angular motion of the storm (0-360)
 * FwdSpeed forward speed of the storm in knots
 * Eye diameter of the eye in nautical miles

`forecasts`

 * Key
 * Adv
 * ObDate
 * FcstDate date/time of the forecast position
 * Lat latitude of the forecast position at FcstDate
 * Lon longitude
 * Wind (kts)
 * Gust (kts)

`forecast_winds`

This dataset list wind radius. There are three values of WindField: 34, 50 and 64. These are wind speeds in knots. NE, SE, SW and NW are quadrants of the storm. So a value of 64 in WindField and a value of 25 for NE means that 64kt winds are *forecast* to extend 25 nautical miles to the northeast of the storm's center.

 * Key 
 * Adv
 * ObDate
 * FcstDate (foreign key forecasts.FcstDate)
 * WindField minimum speed of wind expected (34, 50, 64)
 * NE northeast quadrant, nautical miles
 * SE southeast quadrant, nautical miles
 * SW southwest quadrant, nautical miles
 * NW northwest quadrant, nautical miles

`seas`

Similar to winds but for 12 ft seas.

 * Key
 * Adv
 * ObDate
 * NE
 * SE
 * SW
 * NW

`winds`

Current wind radius for the storm. See `forecast_winds` for details on fields

 * Key
 * Adv
 * ObDate
 * WindField
 * NE
 * SE
 * SW
 * NW

