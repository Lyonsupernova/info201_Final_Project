library(dplyr)
library(ggplot2)
library(shiny)
library(dplyr)
library(bit64)
library(leaflet)
library(plotly)
server <- function(input, output) {
  bathroom_pref <- reactive({
    house_preference %>% 
      filter(bedrooms == input$bedroom) %>% 
      mutate(pps = paste0("$", price_per_square)) %>% 
      mutate(num_bathroom = paste(bathrooms,"bathroom(s)"))
  })
  output$bathroom <- renderPlotly({
    title <- paste0(
      "The bathroom selection(s) with price/sqft: ",
      input$bedroom, " bedroom")
    x <- list(
      title = "Number of Bathrooms"
    )
    y <- list(
      title = "Dollars / Sqft"
    )
      plot_ly(bathroom_pref(), x = ~num_bathroom, y = ~pps,
              type = "scatter", mode = "markers",
              color = ~price_per_square) %>% 
        layout(xaxis = x, yaxis = y
                 , title = title)
  })

  house_price_month_1 <- reactive({
    house_price_month %>% 
      filter(condition == input$conditions_input) %>% 
      filter(bedrooms == input$bedrooms_input)
  })
  output$boxp <- renderPlot({
    boxp <- ggplot(house_price_month_1(), aes(x = months, y = price)) +
      geom_boxplot(outlier.shape = NA, aes(fill = months)) +
      labs(
        title = paste0("Relationship of price and month for ", input$bedrooms_input,
                      " bedrooms houses in condition ",
                      input$conditions_input, " ."),
        x = "Months",
        y = "Price"
      ) +
      scale_y_continuous(limits = input$limit_input, labels = scales::comma)
    return(boxp)
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