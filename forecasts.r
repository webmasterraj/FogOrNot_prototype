# Get fog forecasts for 1/3/6/12/24 hours from now
# Start with 1 hour from now

getPWSForecast <- function(ID) {
	# gets hourly forecasts for next 10 days for 1 pws, with tempDiff and fog readings
	
	forecast.api <- urlBuilder(ID, hourlyAPI())
	forecast.json <- getURL(forecast.api)
	forecast.raw <- fromJSON(forecast.json)
	forecast.df <- flatten(as.data.frame(forecast.raw$hourly_forecast))
	
	# Add variables for tempDiff and fog. fog is limited to 0 (no fog) - 5 (most fog)
	forecast.df <- within(forecast.df, 
		tempDiff <- as.numeric(temp.english) - as.numeric(dewpoint.english)
		)
	forecast.df$fog <- pmax((5 - forecast.df$tempDiff), 0, na.rm = TRUE)
	
	# Add variable for datetime in R friendly format
	forecast.df$datetime <- as.POSIXct(
		paste(forecast.df$FCTTIME.year, forecast.df$FCTTIME.mon_padded, forecast.df$FCTTIME.mday_padded, forecast.df$FCTTIME.hour_padded, forecast.df$FCTTIME.min, sep = "-"),
		format = "%Y-%m-%d-%H-%M"
	)

	forecast.df
}

fogForecast <- function(forecast, hours) {
	predictTime = round_date(Sys.time(), unit = c("hour")) + (hours * 60 * 60)
	forecast[forecast$datetime == predictTime,]$fog
}

addFogForecasts <- function(pws) {
	# function to add columns for for forecast for 1 hour/3/6/12/24 to given location
	forecast <- getPWSForecast(pws$id)
	pws$fog_1hr <- fogForecast(forecast, 1)
	pws$fog_3hr <- fogForecast(forecast, 3)
	pws$fog_6hr <- fogForecast(forecast, 6)
	pws$fog_12hr <- fogForecast(forecast, 12)
	pws$fog_18hr <- fogForecast(forecast, 18)
	pws$fog_24hr <- fogForecast(forecast, 24)
	pws
}

predictFog <- function(locations) {
	for (i in 1:nrow(locations)) {
		locations[i,] <- addFogForecasts(locations[i,])
		Sys.sleep(60/(max_calls_per_minute - 1))
	}
	locations
}

