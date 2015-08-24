require(XML)
require(RCurl)
require(lubridate)
require(plyr)
require(stringr)
require(jsonlite)
require(ggmap)
require(ggplot2)


# Load my other files
source("wu_apis.R")
source("mapping.R")
source("forecasts.R")

# Get locations and basemap
home <- '94122'
locations <- getLocations(home)
basemap <- SFmap(home)


## EXECUTE THIS EVERY TIME

# Predict fog for those locations

locations <- predictFog(locations)


# Display fog map
showMaps <- function () {
	map1hr <- fogMap_1hr(basemap, locations)
	map3hr <- fogMap_3hr(basemap, locations)
	map6hr <- fogMap_6hr(basemap, locations)
	map12hr <- fogMap_12hr(basemap, locations)
	map18hr <- fogMap_18hr(basemap, locations)
	map24hr <- fogMap_24hr(basemap, locations)
	multiplot(map1hr, map3hr, map6hr, map12hr, map18hr, map24hr, cols = 3)
}




## TESTING PURPOSES ONLY
# myvars_locations <- c("neighborhood", "id", "fog_1hr", "fog_3hr", "fog_6hr", "fog_12hr", "fog_24hr")
# temp_locations <- locations[, myvars_locations]


# myvars_pws <- c("FCTTIME.civil", "temp.english", "dewpoint.english", "tempDiff", "fog")
# temp_pws <- temp_pws[, myvars_pws]



# # middle outer sunset
# home2 <- '37.757691,-122.416152'
# locations2 <- getLocations(home2)
# locationsMap(basemap, locations2)

# # mission
# home3 <- "37.757691,-122.416152"
# locations3 <- getLocations(home3)
# locationsMap(basemap3, locations3)

# # ocean beach
# home4 <- "37.748513,-122.505373"
# locations4 <- getLocations(home4)
# locationsMap(basemap3, locations4)


# # "233 rue du faubourg saint-honore, paris"
# home5 <- '48.877344,2.299080'
# locations5 <- getLocations(home5)
# locationsMap(basemap5, locations5)

