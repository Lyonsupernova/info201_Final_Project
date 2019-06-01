library(dplyr)
library(shiny)
house_sales <- read.csv("data/house_sales.csv", stringsAsFactors = FALSE)
View(house_sales)
house_preference <- house_sales %>% 
  mutate(price_per_square = price / sqft_living) %>% 
  group_by(bedrooms, bathrooms) %>% 
  summarise(price_per_square = round(mean(price_per_square), digits = 1),
            n = n()) %>% 
  arrange(-n) %>% 
  head(n = 30)
unique_bedrooms <- sort(unique(house_preference$bedrooms))
unique_bathrooms <- sort(unique(house_preference$bathrooms))

bedroom_select<- selectInput(
  "bedroom",
  label = "The frist bedroom selected ",
  choices = unique_bedrooms,
  selected = 1
) 
page_one <- tabPanel(
  "First Page",
  titlePanel("Bedroom"),
  sidebarLayout(
    sidebarPanel(
      bedroom_select,
      submitButton("Submit")
      ),
    mainPanel(
      plotOutput("bedroom")
    )
  )
)
ui <- navbarPage(
  "House Selection",
  page_one
)