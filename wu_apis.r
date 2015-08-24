# Functions for Weather Underground APIs

urlBase = 'http://api.wunderground.com/api'
key = '28ceb0f69590b457'

max_calls_per_minute <- 10
max_calls_per_day <- 400

urlBuilder <- function(pws, type) {
	paste(urlBase,'/',key,'/',type, pws,'.json',sep='')
}

hourlyAPI <- function() {
	'hourly10day/q/pws:'
}

geoAPI <- function() {
	'geolookup/q/'
}

getLocations <- function(home) {
	locations.json <- getURL(urlBuilder(home, geoAPI()))
	locations.raw <- fromJSON(locations.json)
	locations <- locations.raw$location$nearby_weather_stations$pws$station

	# initialize empty columns for fog forecasts to fill in later
	locations$fog_1hr <- NA
	locations$fog_3hr <- NA
	locations$fog_6hr <- NA
	locations$fog_12hr <- NA
	locations$fog_18hr <- NA
	locations$fog_24hr <- NA

	locations
}

