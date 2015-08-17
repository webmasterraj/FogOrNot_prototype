require(XML)
require(RCurl)
require(lubridate)
require(plyr)
require(stringr)
require(jsonlite)

urlBase = 'http://api.wunderground.com/api'
key = '28ceb0f69590b457'
max_calls_per_minute = 10
max_calls_per_day = 450

innerSunset.ID = 'KCASANFR156'
ID = innerSunset.ID

urlBuilder <- function(pws, type) {
	paste(urlBase,'/',key,'/',type,'/q/pws:',pws,'.json',sep='')
}

histDate <- function(date) {
	paste('history_',date,sep='')
}

getDateData <- function(history.api) {
	history.json <- getURL(history.api)
	history.raw <- fromJSON(history.json)
	history <- as.data.frame(history.raw$history$observations)
	history$tempi.num <- as.numeric(history$tempi)
	history$dewpti.num <- as.numeric(history$dewpti)
	history <- within(history, 
		tempDiff <- tempi.num - dewpti.num)
	history$tempDiff <- history$tempi.num - history$dewpti.num
	history$fog <- as.factor(floor(history$tempDiff))
	history$time <- as.POSIXct(paste(history$date$hour, history$date$min, sep=":"),
		format = "%H:%M")
	flatten(history)
}

dateString <- function(d) {
	year <- sprintf("%04d", year(d))
	month <- sprintf("%02d", month(d))
	day <- sprintf("%02d", day(d))
	paste(year, month, day, sep = "")
}

getData <- function() {
	while((callCount < max_calls_per_day)) {
		print(c(callCount, as.character(date)))
		history.api <- urlBuilder(ID, histDate(dateString(date)))
		dateData <- getDateData(history.api)
		historicalData <- rbind(historicalData, dateData)
		
		date = date - 1
		
		# wait 7 seconds in between api calls
		callCount = callCount + 1
		Sys.sleep(60/(max_calls_per_minute - 1))
	}
}

myvars <- c('tempi', 'dewpti', 'tempDiff', 'fog', 'time', 'date.pretty')
