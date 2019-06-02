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
  output$scatter <- renderPlot({
    scatterP <- ggplot(house_sales_small, aes(
      x = house_sales_small[[input$x_input]],
      y = price
    )) +
      geom_point(aes(
        col = bedrooms
      )) +
      geom_smooth(method = "loess", se = F) +
      labs(subtitle =  paste(input$x_input, "Vs", "price"),
           y = "price",
           x = input$x_input,
           title = "Scatterplot",
           caption = "Source: House Sales King County")
    return(scatterP)
  })
}