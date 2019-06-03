library(dplyr)
library(ggplot2)
library(shiny)
library(dplyr)
library(bit64)
library(leaflet)
server <- function(input, output) {
  bathroom_pref <- reactive({
    house_preference %>% 
      filter(bedrooms == input$bedroom)
  })
  output$bedroom <- renderPlot({
    title <- paste0(
      "The bathroom selections with price/sqft: ",
      input$bedroom, " bedrooom")
    p <- ggplot(bathroom_pref()) +
      geom_point(mapping = aes_string(
        x = "bathrooms",
        y = "price_per_square",
        size = "bathrooms",
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
  house_df <- data.table::fread("data/house_sales.csv", stringsAsFactors = FALSE)
  house_data <- reactive({house_df})
  output$map <- renderLeaflet({
    df <- house_data()
    if(input$color == "condition"){
      colorData <- df[[input$color]]
      pal <- colorFactor(c('#fb8072','#ffffb3','#bebada','#8dd3c7','#80b1d3'), colorData)
    }else{
      colorData <- df[[input$color]]
      pal <- colorBin("RdYlBu", colorData, 4, pretty = FALSE)
    }
    if(input$size == "none"){
      radius <- 25
    }else{
      if(input$size == "sqft_living"){
        radius <- df[[input$size]] / 50
      }
      if(input$size == "grade"){
        radius <- df[[input$size]] * 10
      }
    }
    leaflet(data = df) %>%
      addTiles( # Add default OpenStreetMap map tiles
        urlTemplate = "https://{s}.basemaps.cartocdn.com/rastertiles/voyager_labels_under/{z}/{x}/{y}{r}.png'",
        attribution = '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> &copy; <a href="https://carto.com/attributions">CARTO</a>'
      ) %>%  
      setView( lng = -122.349358
               , lat = 47.620422
               , zoom = 13 ) %>% 
      addCircles(lng = ~long, lat = ~lat,weight = 8, radius = radius,
                 fillOpacity = 0.5, stroke = FALSE,fillColor=pal(colorData),
                 layerId = ~id,
                 popup = paste(
                   sprintf("Rating Score: %d", as.integer(house_sales$grade)), tags$br(),
                   sprintf("Sale Price: $%s", house_sales$price), tags$br(),
                   sprintf("Bedrooms: %s", house_sales$bedrooms), tags$br(),
                   sprintf("Bathrooms: %s", house_sales$bathrooms), tags$br(),
                   sprintf("Build Year: %s", house_sales$yr_built), tags$br(),
                   sprintf("Area: %d sqft", house_sales$sqft_living), tags$br()
      )  
      )
  })
}