# This is app_server.R file.
library(shiny)
library(tidyverse)
library(maps)
library(plotly)

# Load the data

rates_of_resi_pl<- read.csv("Data/Juvenile Residential Placement.csv")
arrests <- read.csv("Data/juv_offenses.csv", stringsAsFactors = F, check.names = F)
rates_by_race <- read.csv("Data/arrest_rates_by_race.csv")

server <- function(input, output) {
  
  # Kelly -----------------------




  # Casey -----------------------
  race_data <- reactive({
    rates_by_race %>%
      select("Year", input$race)
  })
  
  output$race_plot <- renderPlotly({
    race_plot <- ggplot(data = race_data()) +
    geom_line(
      mapping = aes_string(x = "Year", y = input$race),
      color = input$race_color
    ) +
    
    labs(
      title = "Arrests Rates of Race over Time (All Offenses)",
      x = "Year",
      y = "Rate of Arrests (per 100,000 Persons)"
    )
    ggplotly(race_plot)
  })

  # Ryan -----------------------
  
}