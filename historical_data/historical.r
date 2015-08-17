# {**} create functions so I'm not repeating blocks of code
# 
# {**} get data for multiple dates > make prediction based on previous data
# 	for next 3hrs/6hrs/12hrs/24hrs
# 		- watch out for times wrapping around midnight
# 	try multiple ranges of previous data
# 		- eg 1 week ago should be much less predictive than 1 day ago
# 	{?} logistic regression?- or regression tree?- try both
# 
# {**} compare to baseline model of predicted temp - predicted dew point
# 
# Day of the year
# Month
# 
# Weather station as a data point
# Name of the neighborhood
# Interaction features


# setwd("~/Documents/DataSci/Weather")

date = '20150704'

# http://api.wunderground.com/api/28ceb0f69590b457/history_20060405/q/CA/San_Francisco.json
urlBase = 'http://api.wunderground.com/api'
key = '28ceb0f69590b457'

outerSunset.ID = 'KCASANFR302'
westPortal.ID = 'KCASANFR306'
twinPeaks.ID = 'KCASANFR34'
innerSunset.ID = 'KCASANFR156'

urlBuilder <- function(pws, type) {
	paste(urlBase,'/',key,'/',type,'/q/pws:',pws,'.json',sep='')
}

histDate <- function(date) {
	paste('history_',date,sep='')
}

require(XML)
require(RCurl)
require(lubridate)
require(plyr)
require(stringr)

outerSunset.history.api <- urlBuilder(outerSunset.ID, histDate(date))
westPortal.history.api <- urlBuilder(westPortal.ID, histDate(date))
twinPeaks.history.api <- urlBuilder(twinPeaks.ID, histDate(date))
innerSunset.history.api <- urlBuilder(innerSunset.ID, histDate(date))

require(jsonlite)
innerSunset.history.json <- getURL(innerSunset.history.api)
	# innerSunset.history.raw <- fromJSON(innerSunset.history.json, unexpected.escape = 'skip')
	# innerSunset.history <- innerSunset.history.raw$history
	# innerSunset.history.df <- as.data.frame(innerSunset.history$observations)
innerSunset.history.raw <- fromJSON(innerSunset.history.json)
innerSunset.history <- innerSunset.history.raw$history$observations
innerSunset.history$tempi.num <- as.numeric(innerSunset.history$tempi)
innerSunset.history$dewpti.num <- as.numeric(innerSunset.history$dewpti)
innerSunset.history <- within(innerSunset.history, 
	tempDiff <- tempi.num - dewpti.num)
innerSunset.history$tempDiff <- innerSunset.history$tempi.num - innerSunset.history$dewpti.num
innerSunset.history$fog <- as.factor(floor(innerSunset.history$tempDiff))
innerSunset.history$time <- as.POSIXct(paste(innerSunset.history$date$hour, innerSunset.history$date$min, sep=":"),
	format = "%H:%M")

# outerSunset.history.json <- getURL(outerSunset.history.api)
# 	# outerSunset.history.raw <- fromJSON(outerSunset.history.json, unexpected.escape = 'skip')
# 	# outerSunset.history <- outerSunset.history.raw$history
# 	# outerSunset.history.df <- as.data.frame(outerSunset.history$observations)
# outerSunset.history.raw <- fromJSON(outerSunset.history.json)
# outerSunset.history <- outerSunset.history.raw$history$observations
# outerSunset.history$tempi.num <- as.numeric(outerSunset.history$tempi)
# outerSunset.history$dewpti.num <- as.numeric(outerSunset.history$dewpti)
# outerSunset.history <- within(outerSunset.history, 
# 	tempDiff <- tempi.num - dewpti.num)
# outerSunset.history$tempDiff <- outerSunset.history$tempi.num - outerSunset.history$dewpti.num
# outerSunset.history$fog <- as.factor(floor(outerSunset.history$tempDiff))
# outerSunset.history$time <- as.POSIXct(paste(outerSunset.history$date$hour, outerSunset.history$date$min, sep=":"),
# 	format = "%H:%M")

# westPortal.history.json <- getURL(westPortal.history.api)
# 	# westPortal.history.raw <- fromJSON(westPortal.history.json, unexpected.escape = 'skip')
# 	# westPortal.history <- westPortal.history.raw$history
# 	# westPortal.history.df <- as.data.frame(westPortal.history$observations)
# westPortal.history.raw <- fromJSON(westPortal.history.json)
# westPortal.history <- westPortal.history.raw$history$observations
# westPortal.history$tempi.num <- as.numeric(westPortal.history$tempi)
# westPortal.history$dewpti.num <- as.numeric(westPortal.history$dewpti)
# westPortal.history <- within(westPortal.history, 
# 	tempDiff <- tempi.num - dewpti.num)
# westPortal.history$tempDiff <- westPortal.history$tempi.num - westPortal.history$dewpti.num
# westPortal.history$fog <- as.factor(floor(westPortal.history$tempDiff))
# westPortal.history$time <- as.POSIXct(paste(westPortal.history$date$hour, westPortal.history$date$min, sep=":"),
# 	format = "%H:%M")

# twinPeaks.history.json <- getURL(twinPeaks.history.api)
# 	# twinPeaks.history.raw <- fromJSON(twinPeaks.history.json, unexpected.escape = 'skip')
# 	# twinPeaks.history <- twinPeaks.history.raw$history
# 	# twinPeaks.history.df <- as.data.frame(twinPeaks.history$observations)
# twinPeaks.history.raw <- fromJSON(twinPeaks.history.json)
# twinPeaks.history <- twinPeaks.history.raw$history$observations
# twinPeaks.history$tempi.num <- as.numeric(twinPeaks.history$tempi)
# twinPeaks.history$dewpti.num <- as.numeric(twinPeaks.history$dewpti)
# twinPeaks.history <- within(twinPeaks.history, 
# 	tempDiff <- tempi.num - dewpti.num)
# twinPeaks.history$tempDiff <- twinPeaks.history$tempi.num - twinPeaks.history$dewpti.num
# twinPeaks.history$fog <- as.factor(floor(twinPeaks.history$tempDiff))
# twinPeaks.history$time <- as.POSIXct(paste(twinPeaks.history$date$hour, twinPeaks.history$date$min, sep=":"),
# 	format = "%H:%M")


require(ggplot2)
require(scales)
par(mfrow = c(2,2))

# outerSunset.graph <- ggplot(aes(x = time, y = tempDiff), 
# 	data = outerSunset.history) + 
# geom_point(aes(color = outerSunset.history$fog)) +
# geom_hline(aes(yintercept = 4)) +
# scale_x_datetime(breaks = "3 hours", minor_breaks = "1 hour", labels = date_format("%H:%M")) + 
# ggtitle("outerSunset")

# innerSunset.graph <- 
ggplot(aes(x = time, y = tempDiff), 
	data = innerSunset.history) + 
geom_point(aes(color = innerSunset.history$fog)) +
geom_hline(aes(yintercept = 4)) +
scale_x_datetime(breaks = "3 hours", minor_breaks = "1 hour", labels = date_format("%H:%M")) + 
ggtitle("innerSunset")

# westPortal.graph <- ggplot(aes(x = time, y = tempDiff), 
# 	data = westPortal.history) + 
# geom_point(aes(color = westPortal.history$fog)) +
# geom_hline(aes(yintercept = 4)) +
# scale_x_datetime(breaks = "3 hours", minor_breaks = "1 hour", labels = date_format("%H:%M")) + 
# ggtitle("westPortal")

# twinPeaks.graph <- ggplot(aes(x = time, y = tempDiff), 
# 	data = twinPeaks.history) + 
# geom_point(aes(color = twinPeaks.history$fog)) +
# geom_hline(aes(yintercept = 4)) +
# scale_x_datetime(breaks = "3 hours", minor_breaks = "1 hour", labels = date_format("%H:%M")) + 
# ggtitle("twinPeaks")

# require(gridExtra)
# grid.arrange(innerSunset.graph)

