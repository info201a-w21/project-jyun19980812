# This is app_ui.R file.

library(shiny)

intro_panel <- tabPanel(
  "Introduction",
  h1("Introduction")
)

# Kelly -----------------------

offense_type <- sidebarLayout(
  sidebarPanel(
    num_bins <- sliderInput(
      inputId = "bins",
      label = "Choose the number of bins",
      min = 1,
      max = 20,
      value = 10
    ),
    bin_width <- sliderInput(
      inputId = "width",
      label = "Change the width of the bins",
      min = 0,
      max = 1,
      value = 0.5)
  ),
  mainPanel(
    plotlyOutput(outputId = "chart")
  )
)

interactive1_panel <- tabPanel(
  "Interactive 1",
  h1("Juvenile Arrests By Offense Type"),
  offense_type
)


# Casey (Arrests rates by race) -----------------------

# widgets in sidebar
race_sidebar <- sidebarPanel(

  selectInput(
    inputId = "race",
    label = h3("Select a race:"),
    choices = c(
      "White", "Black", "Asian", "Minority",
      "American Indian" = "American.Indian"
    )
  ),
  
  sliderInput(
    inputId = "race_year_range", 
    label = h3("Select a year range:"),
    sep = "",
    min = 1980, 
    max = 2019,
    value = c(1980, 2019)
  ),

  selectInput(
    inputId = "race_color",
    label = h3("Select color:"),
    choices = c("Black", "Blue", "Red", "Orange", "Green")
  )
)

# main panel with plot
race_main_panel <- mainPanel(
  titlePanel("Arrests Over Time"),
  plotlyOutput(outputId = "race_plot")
)

# put page together
interactive2_panel <- tabPanel(
  "Race",
  h1("Juvenile Arrests by Race"),
  race_sidebar,
  race_main_panel
)


# Ryan -----------------------

# Create Sidebar that shows dropdown menu which user can select.
state_df <- data_resi_pl %>%
  distinct(State)

map_layout <- sidebarLayout(
  sidebarPanel(
    h2("Map on Juvenile Residential Placement Rate in 2017"),
    p("It is important to see the rate of juvenile being incarcerated.
      This chart was intended to show the information of the total juvenile 
      residential placement rate in U.S. varied by states in 2017. 
      This chart is interactive, which means that the user is able to select 
      the State to see the rate of that state's juvenile residential placement 
      in 2017, and compare with other state or region to see which state the 
      juvenile incarceration seems most prevalent."),
    selectInput(
      inputId = "state_name",
      label = "State of Interest",
      choices = state_df
    )
  ),
  mainPanel(plotOutput(outputId = "map"))
)

# Creating Panel for Juvenile Placement Map.
map_panel <- tabPanel("Map of Juvenile Placement", map_layout)


# Panel for Summary -------------------------------------------------------
summary_panel <- tabPanel(
  "Summary",
  h1("Summary")
)


ui <- navbarPage(
  "Juvenile Incarceration",
  intro_panel,
  interactive1_panel,
  interactive2_panel,
  #interactive3_panel,
  map_panel,
  summary_panel
)