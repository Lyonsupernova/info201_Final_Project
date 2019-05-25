library(ggplot2)
library(dplyr)
library(tidyr)

house_sales <- read.csv("data/house_sales.csv", stringsAsFactors = FALSE)
price_month_plot <- function(dataset) {
  relationship_price_month <- dataset %>% 
    mutate(month = substr(date, 5, 6)) %>% 
    mutate(months = as.factor(month))
  
  ggplot(relationship_price_month,aes(x = months, y = price)) + 
    geom_boxplot(outlier.shape = NA ,aes(fill = months)) +
    labs(
      title = "Relationship of price and month",
      x = "Months",
      y = "Price"
    ) +
    scale_y_continuous(limits = c(70000,1050000), labels = scales::comma)
}

price_month_plot(house_sales)