library(dplyr)
library(ggplot2)
library(shiny)
View(midwest)
server <- function(input, output) {
  bathroom_pref <- reactive({
    house_preference %>% 
      filter(bedrooms == input$bedroom)
  })
  output$bedroom <- renderPlot({
    title <- paste0(
      "The bathroom selections with price/sqft: ",
      input$bedroom, "bedrooom")
    p <- ggplot(bathroom_pref()) +
      geom_point(mapping = aes_string(
        x = "bathrooms",
        y = "price_per_square",
        size = "n",
        color = "price_per_square"
      )) +
      labs(x = paste0(input$bedroom, " bedroom"),
           y = "dollars / sqft", title = title)
    p
  })
}