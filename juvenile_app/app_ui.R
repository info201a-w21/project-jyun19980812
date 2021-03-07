# This is app_ui.R file.

# Create Sidebar that shows dropdown menu which user can select.
country_df <- rates_of_resi_pl %>%
  distinct(State)

map_layout <- sidebarLayout(
  sidebarPanel(
    h2("Map on Juvenile Placement Rate over the World"),
    p("It is important to note that lots of Co2 have been produced throughout
      the world. Thus, it will be meaningful to look through countries in the
      world to see how much Co2 have been cumulated from early as 1750 to most
      recent year, 2019. This map shows the cumulated Co2 with the dropdown menu 
      that have choices of countries which the user may select to see the 
      country of their interest."),
    selectInput(
      inputId = "state_name",
      label = "State of Interest",
      choices = country_df
    )
  ),
  mainPanel(plotOutput(outputId = "map"))
)

# Creating Panel for Juvenile Placement Map.
map_panel <- tabPanel("Map of Juvenile Placement", map_layout)
ui <- navbarPage(
  map_panel
)