# This is app_server.R file.
library(shiny)
library(tidyverse)
library(maps)
library(plotly)

# Load the data
data_resi_pl<- read.csv("Data/Juvenile Residential Placement.csv") %>% 
  mutate(State = tolower(State.of.offense)) 
arrests <- read.csv("Data/juv_offenses.csv", stringsAsFactors = F, check.names = F)
rates_by_race <- read.csv("Data/arrest_rates_by_race.csv")

server <- function(input, output) {
  
# Juvenile offenses plot -------------------
  output$chart <- renderPlotly({
    chart_data <- arrests %>% 
      top_n(input$bins + 2, wt = `0 to 17`)
    
    chart_data <- chart_data[-c(1, 2), ]
    
    my_plot <- ggplot(data = chart_data) +
      geom_col(
        mapping = aes(x = reorder(Offenses, `0 to 17`), y = `0 to 17`),
        width = input$width
      ) +
      scale_y_continuous(labels = comma, n.breaks = 8) +
      theme(axis.text.x = element_text(angle = 25, hjust = 1)) +
      labs(
        x = "Offense Type",
        y = "Number of Arrests",
        title = paste0("Top ", input$bins , " Juvenile Offense Types")
      ) +
      coord_flip()
    
    ggplotly(my_plot)
  })


# Juvenile arrest by race plot -------------------

  race_data <- reactive({
    rates_by_race %>%
      select("Year", input$race) %>%
      filter(
        Year >= input$race_year_range[1],
        Year <= input$race_year_range[2]
      )
  })
  
  output$race_plot <- renderPlotly({
    race_plot <- ggplot(data = race_data()) +
    geom_line(
      mapping = aes_string(x = "Year", y = input$race),
      color = input$race_color
    ) +
    
    labs(
      title = paste("Arrests Rates of", input$race, "Juveniles over Time"),
      x = "Year",
      y = "Rate of Arrests (per 100,000 Persons)"
    )
    
    ggplotly(race_plot)
  })


# Map of juvenile residential placement rate -----------------------
  
  output$map <- renderPlot({
    # Selecting state to see the state of interest.
    state_input <- input$state_name
    
    # Merge the residential placement rate data to the U.S. shapefile.
    rates_of_resi_pl<- data_resi_pl %>%
      filter(State == state_input) %>%
      select(State, Total)
    
    # Creating State shapefile. 
    data_of_state <- map_data("state") %>% 
      mutate(State = region) %>% 
      left_join(rates_of_resi_pl, by = "State")
    
    # Creating a map that shows the total juvenile residential placement rate 
    # in U.S. varied by states
    map_of_juvenile <- ggplot(data_of_state) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = Total),
        color = "gray",
        size = .1
      ) +
      coord_quickmap() +
      labs(
        title = paste("Juvenile Residential Placement Rates in ", state_input,  
                      " in 2017"), 
        fill = "Residential Placement Rate") +
        scale_fill_continuous(limits = c(0, max(data_resi_pl$Total)), 
                            na.value = "white", low = "yellow", high = "red") +
      theme_void()
    
    return(map_of_juvenile)
  })

# Plot that shows the average arrests of all races -----------------
  
  output$scatter_plot <- renderPlotly({
    # Make a scatterplot  that shows the average arrests of all races over the
    # year of 1980 to 2019
    rates_by_race_long <- gather(
      rates_by_race,
      key = Race,
      value = Rates,
      -Year
    )
      
    plot_of_average_arrest <- ggplot(data = rates_by_race_long) +
      geom_point(
        mapping = aes(x = Year, y = Rates, color = Race),
        alpha = .6
      ) +
      
      labs(
        title = "Rate of Average Juvenile Arrests of All Races in 1980 to 2019",
        x = "Time from 1980 to 2019",
        y = "Average Juvenile Arrests Rate",
        color = "Races"
      )
    
    ggplotly(plot_of_average_arrest)
  })

}