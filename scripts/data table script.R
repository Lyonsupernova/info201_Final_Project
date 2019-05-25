#house_sales <- read.csv("data/house_sales.csv", stringsAsFactors = FALSE)

library(dplyr)

# finds average square footage, bedroom, bath,
# and price for a given range of square footage
# provides insight on expected cost of housing
# and number of beds/bath per range of square footage
get_chart <- function(dataset) {
  dataset %>%
    select(price, bedrooms, bathrooms, sqft_living) %>%
    mutate(sqft_range = cut(sqft_living,
      breaks = seq(0, 14000, by = 1000),
      right = TRUE, dig.lab = 10, labels = c(
        "0 - 1,000", "1,000 - 2,000",
        "2,000 - 3,000", "3,000 - 4,000", "4,000-5,000", "5,000 - 6,000",
        "6,000 - 7,000", "7,000 - 8,000", "8,000 - 9,000", "9,000 - 10,000",
        "10,000 - 11,000", "11,000 - 12,000", "12,000 - 13,000",
        "13,000 - 14,000"
      )
    )) %>%
    group_by(sqft_range) %>%
    summarize(
      avg_sqft = format(round(mean(sqft_living), 2), big.mark = ","),
      mean_bd = format(round(mean(bedrooms), 1)),
      mean_bath = format(round(mean(bathrooms), 1)),
      mean_price = format(mean(price), big.mark = ",")
    )
}


#get_chart(house_sales)