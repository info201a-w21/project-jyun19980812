# This is app_server.R file.

# Creating a table that has information about the total residential placement 
# rate of juveniles.
rates_of_resi_pl<- read.csv(file = "../data/Juvenile Residential Placement.csv")%>%
  mutate(State = tolower(State.of.offense)) %>% 
  select(State, Total)
# Creating State shapefile.
data_of_map <- map_data("state") %>% 
  rename(State = region) #%>%
  #left_join(rates_of_resi_pl, by = "State")

server <- function(input, output) {
  output$map <- renderPlot({
    state_input <- input$state_name
  # Merge the residential placement rate data to the U.S. shapefile.
    state_data <- rates_of_resi_pl %>% 
      filter(State == state_input) %>% 
      left_join(data_of_map, by = "State")
    
  
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
    map_of_juvenile <- ggplot(state_data) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = Total),
        color = "brown",
        size = .1
      ) +
      coord_quickmap() +
      labs(fill = "Residential Placement Rate") +
      scale_fill_continuous(limits = c(0, max(rates_of_resi_pl$Total)), 
                          na.value = "white", low = "yellow", high = "red") +
      blank_theme +
      ggtitle("Juvenile Residential Placement Rates by States in 2017")
    return(map_of_juvenile)
  })
}