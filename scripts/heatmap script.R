library(ggmap)
library(ggplot2)

base_plot <- qmplot(
  data = house_sales,               # name of the data frame
  x = long,                     # data feature for longitude
  y = lat,                      # data feature for latitude
  geom = "blank",               # don't display data points (yet)
  maptype = "toner-background", # map tiles to query
  darken = 0,                  # darken the map tiles
  legend = "bottomright"            # location of legend on page
)

