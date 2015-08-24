# Functions for mapping

SFmap <- function(home) {
	get_map(
		location = home,
		zoom = 13,
		maptype = c("terrain")
		)
}

locationsMap <- function(map, locations) {
	ggmap(map) +
	geom_point(aes(x = lon, y = lat), data = locations, colour = "blue", size = 3)
}

fogMap_1hr <- function(map, locations) {
	ggmap(map) +
	geom_point(aes(x = lon, y = lat, alpha = fog_1hr), data = locations, colour = "blue", size = 20) +
	geom_point(aes(x = 37.763266, y = -122.473647, alpha = 5), data = locations, colour = "red", size = 2) +
	theme(legend.position="none", axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank()) +
	ggtitle("fog_1hr")
}

fogMap_3hr <- function(map, locations) {
	ggmap(map) +
	geom_point(aes(x = lon, y = lat, alpha = fog_3hr), data = locations, colour = "blue", size = 20) +
	geom_point(aes(x = 37.763266, y = -122.473647, alpha = 5), data = locations, colour = "red", size = 2) +
	theme(legend.position="none", axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank()) +
	ggtitle("fog_3hr")
}

fogMap_6hr <- function(map, locations) {
	ggmap(map) +
	geom_point(aes(x = lon, y = lat, alpha = fog_6hr), data = locations, colour = "blue", size = 20) +
	geom_point(aes(x = 37.763266, y = -122.473647, alpha = 5), data = locations, colour = "red", size = 2) +
	theme(legend.position="none", axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank()) +
	ggtitle("fog_6hr")
}

fogMap_12hr <- function(map, locations) {
	ggmap(map) +
	geom_point(aes(x = lon, y = lat, alpha = fog_12hr), data = locations, colour = "blue", size = 20) +
	geom_point(aes(x = 37.763266, y = -122.473647, alpha = 5), data = locations, colour = "red", size = 2) +
	theme(legend.position="none", axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank()) +
	ggtitle("fog_12hr")
}

fogMap_18hr <- function(map, locations) {
	ggmap(map) +
	geom_point(aes(x = lon, y = lat, alpha = fog_18hr), data = locations, colour = "blue", size = 20) +
	geom_point(aes(x = 37.763266, y = -122.473647, alpha = 5), data = locations, colour = "red", size = 2) +
	theme(legend.position="none", axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank()) +
	ggtitle("fog_18hr")
}

fogMap_24hr <- function(map, locations) {
	ggmap(map) +
	geom_point(aes(x = lon, y = lat, alpha = fog_24hr), data = locations, colour = "blue", size = 20) +
	geom_point(aes(x = 37.763266, y = -122.473647, alpha = 5), data = locations, colour = "red", size = 2) +
	theme(legend.position="none", axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank()) +
	ggtitle("fog_24hr")
}


multiplot <- function(..., plotlist=NULL, cols) {
    require(grid)

    # Make a list from the ... arguments and plotlist
    plots <- c(list(...), plotlist)

    numPlots = length(plots)

    # Make the panel
    plotCols = cols                          # Number of columns of plots
    plotRows = ceiling(numPlots/plotCols) # Number of rows needed, calculated from # of cols

    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(plotRows, plotCols)))
    vplayout <- function(x, y)
        viewport(layout.pos.row = x, layout.pos.col = y)

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
        curRow = ceiling(i/plotCols)
        curCol = (i-1) %% plotCols + 1
        print(plots[[i]], vp = vplayout(curRow, curCol ))
    }

}