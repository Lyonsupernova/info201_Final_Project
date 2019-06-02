library(dplyr)
library(shiny)
house_sales <- read.csv("data/house_sales.csv", stringsAsFactors = FALSE)
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
  selected = 2
) 
page_one <- tabPanel(
  "First Page",
  titlePanel("Bedroom Selection"),
  h5("Do you know how many bathrooms would be the best choice for you to 
     select which types of house style you prefer. In the below select
     box, choose how many bedrooms you want to live in, and we will 
     give you a satisfactory answer about the price/sqft and bathroom 
     number!"),
  sidebarLayout(
    sidebarPanel(
      bedroom_select,
      helpText("Note: dollars / sqft we used the price to divide with the 
               living area of house.")
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