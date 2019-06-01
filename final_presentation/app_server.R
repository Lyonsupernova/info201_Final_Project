library(dplyr)
library(ggplot2)
library(shiny)

server <- function(input, output) {
  output$comparison <- renderplot({
    title <- paste0(
      "The comparison between two house selections: ",
      input$bedroom1, "bedrooom", input$bathroom1, "bathroom v.s.")
    p <- ggplot(house_preference) +
      geom_point(mapping = aes_string(
        x = ,
        y = price_per_square, color = 
      )) +
      labs(x = input$x_var, y = input$y_var, title = title)
    p
  })
}