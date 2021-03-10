# This is app_ui.R file.

library(shiny)

intro_panel <- tabPanel(

  "Introduction",
  tags$h1("Juvenile Incarceration in the United States"),
  tags$div(
    tags$img(alt = "Juvenile Incarceration", src = "photo-1.jpg")
  ),

  tags$h3("Motivations"),
  tags$p("In recent years, there has been a growing concern towards crimes
        committed by adolescents, the rate of juvenile incarceration in the
        United States, and what the consequences are of adolescents spending
        time in jail. Studies have shown that juveniles who have spent time in
        jail or prison perform worse in school than their peers and have an
        increased chance of recidivism in their futures. This provoked our
        research into juvenile crime and incarceration, their rates of
        occurrence, and patterns in the racial and regional factors that
        influence these crimes. We want to ask these questions about patterns in
        the rates of crime, where incarceration is happening, and who are
        committing these crimes because this type of information influences
        government and public attitudes and policy making."),

  tags$h3("Our Data"),
  tags$p("The data we are using comes from the U.S Department of Justice -
         Office of Justice Programs. These datasets provide information on
         different offenses committed by juveniles, rates of juvenile arrests,
         and rates of arrest in each state across the United States."),
  tags$ul(
    tags$li(
      a("Juvenile Arrest Rate Trends by Race, 1980-2019",
      href = "https://www.ojjdp.gov/ojstatbb/crime/JAR_Display.asp?ID=qa05260&selOffenses=1",
      target = "_blank")
    ),
    tags$li(
      a("Juvenile Residential Placement Rates, 2017",
      href = "https://www.ojjdp.gov/ojstatbb/corrections/qa08601.asp?qaDate=2017",
      target = "_blank")
    ),
    tags$li(
      a("Juvenile Arrests by Offense and Age group, 2019",
      href = "https://www.ojjdp.gov/ojstatbb/crime/ucr.asp?table_in=1&selYrs=2019&rdoGroups=1&rdoData=c",
      target = "_blank")
    )
  ),

  tags$h3("Questions we hope to answer"),
  tags$ul(
    tags$li("What kinds of offenses are juveniles committing and at what rates?"),
    tags$li("How have the rates of juvenile arrests changed over time?"),
    tags$li("In which states or regions of the U.S. is juvenile incarceration
            most prevalent?")
  )

)

# Kelly - Arrests by Offense -----------------------

offense_type <- sidebarLayout(
  sidebarPanel(

    h2("Juvenile Arrests By Offense Type"),
    p("This interactive chart is designed to display information about juvenile
      arrests by offense. Users can select up to 20 of the top offenses committed
      by juveniles. This can help to reveal which offenses are most relevant
      and at what rates they occur."),

    num_bins <- sliderInput(
      inputId = "bins",
      label = "Choose the number of bins:",
      min = 1,
      max = 20,
      value = 10
    ),
    bin_width <- sliderInput(
      inputId = "width",
      label = "Change the width of the bins:",
      min = 0,
      max = 1,
      value = 0.5)
  ),
  mainPanel(
    plotlyOutput(outputId = "chart")
  )
)

offenses_panel <- tabPanel(
  "Juvenile Offenses",
  offense_type
)


# Casey - Arrests rates by race -----------------------

# widgets in sidebar
race_sidebar <- sidebarPanel(
  h2("Juvenile Arrests by Race"),
  p("This interactive chart is designed to display information about juvenile
    arrests by race. Users can select which race and what time frame to display,
    making it easy to reveal patterns across different races and time periods."),

  selectInput(
    inputId = "race",
    label = "Select a race:",
    choices = c(
      "White", "Black", "Asian", "Minority",
      "American Indian" = "American.Indian"
    )
  ),

  sliderInput(
    inputId = "race_year_range",
    label = "Select a year range:",
    sep = "",
    min = 1980,
    max = 2019,
    value = c(1980, 2019)
  ),

  selectInput(
    inputId = "race_color",
    label = "Select color:",
    choices = c("Black", "Blue", "Red", "Orange", "Green")
  )
)

# main panel with plot
race_main_panel <- mainPanel(
  plotlyOutput(outputId = "race_plot")
)

# put page together
race_plot_panel <- tabPanel(
  "Incarceration by Race",
  race_sidebar,
  race_main_panel
)


# Ryan - Arrests by State -----------------------

# Create Sidebar that shows dropdown menu which user can select.
state_df <- data_resi_pl %>%
  distinct(State)

map_layout <- sidebarLayout(
  sidebarPanel(
    h2("Map on Juvenile Residential Placement Rate in 2017"),
    p("This chart is intended to show the information of the total juvenile
      residential placement rate in U.S. varied by states in 2017.
      The residential placement rate is the number of juvenile offenders in
      residential placement ages 10 through the upper age
      of original juvenile court jurisdiction in each state.
      This chart is interactive, allowing the user to display a specific state's
      juvenile residential placement."),
    selectInput(
      inputId = "state_name",
      label = "State of Interest:",
      choices = state_df
    )
  ),
  mainPanel(
    plotOutput(outputId = "map")
  )
)

# Creating Panel for Juvenile Placement Map.
map_panel <- tabPanel(
  "Juvenile Placement",
  map_layout
)


# Panel for Summary -------------------------------------------------------
summary_panel <- tabPanel(
  "Summary",
  tags$h1("Our Findings"),
  #tags$div(
  #  tags$img(alt = "Juvenile Incarceration", src = "photo-1.jpg")
  #),
  #tags$p(""),
  tags$h3("Major Trends"),
  tags$p("We were able to uncover trends in the rates of juvenile incaraceration
         across different races over time. From our line plot, we have
         identified that all races have seen a decrease in incarceration
         over the years. This helps us to answer our question, how have the
         rates of juvenile arrests changed overtime? Our observations goes
         against our initial prediction that juvenile incarceration has
         increased in recent years."),
  tags$p("Our map showing rates of juvenile residenital placement give us great
         insight into answering the question: where is juvenile incarceration
         most prevalant in the United States? We saw a broad range of
         residential placement rates in 2017 - from 27 to 302 per 100,000
         juveniles. We found that 26 states have a low to moderately low rate of
         residential placement (27 to 138 per 100,000); 20 states have a
         moderately high rate of juvenile placement (138 to 219 per 100,000);
         and 5 states had a high rate of juvenile placement (220 to 302 per
         100,000)."),
  tags$p("Additionally, we were able to answer the question: what kinds of
         offenses are juveniles committing and at what rates?. identify which
         offenses are committed most commonly by juveniles ages 0-17. Based on
         the data, assault, propery crime, larcerny, drug abuse violations, and
         disorderly conduct are among the top five crimes committed by this age
         group in the United States."),

  tags$h3("Notable Observations"),
  tags$ul(
    tags$li("The leading juvenile offense is simple assault with over 126,130
            arrests, followed by property crime with 119,790 arrests."),
    tags$li("The peak of juvenile incarceration was between 1990 and 2000 and
            in the following years, there has been a gradual decline for all
            races. We can also found while the rates for all races follow the same
            trends, Black juveniles have the highest overall rate of arrest and
            Asian juveniles have the lowest."),
    tags$li("We have found that Wyoming has the highest rate of juvenile
            residential placement and Connecticut has the lowest rate.")
  ),

  tags$h3("Related Findings"),
  tags$p("Below, we have included a scatterplot to show the average
         juvenile arrests varied by race over time. This plot reveals
         that from the year of 1980 through 1996, the average rate of juvenile
         arrest rates increased, and in early 2000, the rates started
         to go down, much like we observed previously in our line plot."),
  plotlyOutput(outputId = "scatter_plot")
)


ui <- navbarPage(
  "Juvenile Incarceration",
  intro_panel,
  offenses_panel,
  race_plot_panel,
  map_panel,
  summary_panel
)
