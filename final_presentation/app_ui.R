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
      selectInput(
        "bedroom",
        label = "The frist bedroom selected ",
        choices = unique_bedrooms,
        selected = 2
      ) ,
      helpText("Note: dollars / sqft we used the price to divide with the 
               living area of house.")
      ),
    mainPanel(
      plotOutput("bedroom")
    )
  )
)

house_sales_small <- house_sales %>% 
  arrange(bedrooms) %>%
  filter(bedrooms < 2)
col_names2 <- colnames(house_sales_small)
x_input <- selectInput(
  inputId = "x_input",
  label = "select for x",
  choices = col_names2[c(6,7,12,15,20,21)]
)

page_two <- tabPanel(
  "Second Page",
  titlePanel("Scatter for all sales"),
  sidebarLayout(
    sidebarPanel(
      x_input  
    ),
    mainPanel(
      plotOutput("scatter")
    )
  )
)

ui <- navbarPage(
  "House Selection",
  page_one,
  page_two
)