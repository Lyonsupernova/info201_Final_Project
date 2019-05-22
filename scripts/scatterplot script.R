library(ggplot2)
library(dplyr)
library(tidyr)

house_sales <- read.csv("data/house_sales.csv", stringsAsFactors = FALSE)
price_month_plot <- function(dataset) {
  relationship_price_month <- house_sales %>% 
    mutate(month = substr(date, 5, 6)) %>% 
    group_by(month) %>% 
    summarize(avg_price = mean(price))
  
  plot <- ggplot(relationship_price_month) + 
    geom_point(mapping = aes(x = month, y = avg_price)) + 
    ggtitle("Relationship of price and month") 
  return(plot)
}

price_month_plot(house_sales)
