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
  
  # Kelly -----------------------




  # Casey -----------------------
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
      title = "Arrests Rates of Race over Time (All Offenses)",
      x = "Year",
      y = "Rate of Arrests (per 100,000 Persons)"
    )
    
    ggplotly(race_plot)
  })

  # Ryan -----------------------
  #rates_of_resi_pl<- data_resi_pl%>%
    #mutate(State = tolower(State.of.offense)) %>% 
    #select(State, Total)

  #data_of_state <- map_data("state") #%>% 
    #mutate(State = region) #%>%
  #left_join(rates_of_resi_pl, by = "State")
  
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
    
    # Define a minimalist theme for maps
    blank_theme <- theme_bw() +
      theme(
        axis.line = element_blank(), # remove axis lines
        axis.text = element_blank(), # remove axis labels
        axis.ticks = element_blank(), # remove axis ticks
        axis.title = element_blank(), # remove axis titles
        plot.background = element_blank(), # remove gray background
        panel.grid.major = element_blank(), # remove major grid lines
        panel.grid.minor = element_blank(), # remove minor grid lines
        panel.border = element_blank() # remove border around plot
      )
    
    # Creating a map that shows the total juvenile residential placement rate 
    # in U.S. varied by states
    map_of_juvenile <- ggplot(data_of_state) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = Total),
        color = "brown",
        size = .1
      ) +
      coord_quickmap() +
      labs(fill = "Residential Placement Rate") +
      scale_fill_continuous(limits = c(0, max(data_resi_pl$Total)), 
                            na.value = "white", low = "yellow", high = "red") +
      blank_theme +
      ggtitle("Juvenile Residential Placement Rates by States in 2017")
    return(map_of_juvenile)
  })

}