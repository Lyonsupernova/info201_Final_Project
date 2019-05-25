library(ggmap)
library(ggplot2)

#house_sales <- read.csv("data/house_sales.csv", stringsAsFactors = FALSE)

heat_map <- function(dataset) {
  base_plot <- qmplot(
    data = dataset, # name of the data frame
    x = long, # data feature for longitude
    y = lat, # data feature for latitude
    geom = "blank", # don't display data points (yet)
    maptype = "toner-background", # map tiles to query
    darken = 0, # darken the map tiles
    legend = "bottomright" # location of legend on page
  )

  base_plot +
    geom_polygon(
      stat = "density2d", # calculate two-dimensional density of points
      mapping = aes(fill = stat(level)), # use  density to set the fill
      alpha = .3 # Set the alpha (transparency)
    ) +
    scale_fill_gradient2(
      low = "white",
      mid = "yellow",
      high = "red"
    ) +
    labs(title = "King County House Sale in 2015 HeatMap") +
    theme(plot.margin = margin(.3, 0, 0, 0, "cm"))
}

#heat_map(house_sales)