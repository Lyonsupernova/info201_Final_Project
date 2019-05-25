library(tidyr)
get_summary_info <- function(dataset) {
  ret <- list()
  ret$column_name <- colnames(dataset)
  ret$most_bedrooms <- dataset %>% 
    filter(bedrooms == max(bedrooms)) %>% 
    pull(bedrooms)
  ret$most_expensive_room <- dataset %>% 
    filter(price == max(price)) %>% 
    pull(price)
  ret$cheapest_room <- dataset %>% 
    filter(price == min(price)) %>% 
    select(price)
  ret$largest_houst_ft <- dataset %>%
    filter(sqft_living == max(sqft_living)) %>% 
    select(sqft_living)
  return (ret)
} 
#get_summary_info(house_sales)