library(ggplot2)
library(dplyr)
library(tidyr)

year_price_plot <- function(dataset) {
  year_price <- dataset %>%
    select(yr_built, price) %>%
    group_by(yr_built) %>%
    summarise(ave_price = mean(price))

  ggplot(year_price, aes(x = yr_built, y = ave_price)) +
    geom_line(color = "#E69F00") +
    labs(
      title = "Relationship between Built Year and Average Price",
      x = "Built Year",
      y = "Average Price"
    ) +
    scale_x_continuous(breaks = seq(1900, 2015, by = 10)) +
    scale_y_continuous(labels = scales::comma)
}