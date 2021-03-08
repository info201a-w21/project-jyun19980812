# This is app_ui.R file.

library(shiny)

intro_panel <- tabPanel(
  "Introduction",
  tags$h2("Introduction of Juvenile Arrest"),
  tags$div(
    tags$img(alt = "Juvenile Incarceration", src = "photo-1.jpg")
           ),
  tags$p("Many people, including members of our group, have noticed a growing concern
    about crimes committed by young adolescents and the rate of juvenile 
    incarceration in the U.S. This provoked our group to research juvenile crime
    and incarceration, compare the rates of occurrence, and analyze the racial 
    and gender factors that may show inequality in these crimes. We want to ask
    these questions about patterns in the rates of crime, where these crimes are
    happening, and who are committing these crimes because this type of 
    information influences government attitudes and policy making."),
  tags$em("Some data-driven questions that we hope to answer are:"),
  tags$ul(
    tags$li("What are the overall proportions of offenses caused by juveniles?"),
    tags$li("How have the rates of juvenile arrests changed over time?"),
    tags$li("Which state or region of the U.S. does juvenile incarceration seem most prevalent?")
  )
  
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
  "Juvenile Offenses",
  h1("Juvenile Arrests By Offense Type"),
  offense_type
)


# Casey (Arrests rates by race) -----------------------

# widgets in sidebar
race_sidebar <- sidebarPanel(
  h2("Juvenile Arrests by Race"),

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
race_plot_panel <- tabPanel(
  "Race",
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
  tags$h2("Summary takeaways of the project"),
  #tags$div(
  #  tags$img(alt = "Juvenile Incarceration", src = "photo-1.jpg")
  #),
  #tags$p(""),
  tags$strong("Our summary takeaways are listed below:"),
  tags$ul(
    tags$li("The leading juvenile offense is 126130 with over 126,130 arrests,
            followed by Property Crime Index with 119,790"),
    tags$li("The rate of arrests are per 100,000 persons from ages 10-17. 
            The chart shows that there was an increase of arrests between 1990 
            and 2000 and since then, there has been a gradual decline for all 
            races. We can also see while the rates for all races follow the same
            trends, Black juveniles have the highest overall rate of arrest and 
            Asian juveniles have the lowest."),
    tags$li("The residential placement rate is the number of juvenile offenders
            in residential placement per 100,000 juveniles age 10 through the 
            upper age of original juvenile court jurisdiction in each state. 
            In the data, we are able to see Wyoming having the highest rate, 
            whereas Connecticut having the lowest rate.")
  ),
  tags$p("We have included this table to show time trends on average juvenile 
         arrests rate by each year. This table reveals that from the year of 
         1980 through 1996, the average rate was increasing, and in early 2000,
         the rates started to go down."),
  tableOutput(outputId = "table")
)


ui <- navbarPage(
  "Juvenile Incarceration",
  intro_panel,
  interactive1_panel,
  race_plot_panel,
  map_panel,
  summary_panel
)
