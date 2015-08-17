# Daily run:
# Load R workspace
# Load 'historical_loop.r' source file
# Load 'historical_run_this.r'
	# Set callCount = 0
	# run getData()
	# recreate data_short

max_calls_per_day = 100

callCount = 0

getData()

data_short <- historicalData[,myvars]