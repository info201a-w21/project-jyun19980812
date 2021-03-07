# This is app_ui.R file.

library(shiny)

intro_panel <- tabPanel(
  "Introduction",
  h1("Introduction")
)

# Kelly -----------------------

interactive1_panel <- tabPanel(
  "Interactive 1",
  h1("Kelly's Interactive")
)


# Casey -----------------------

race_sidebar <- sidebarPanel(
  selectInput(
    inputId = "race",
    label = "Select a race:",
    choices = c(
      "White", "Black", "Asian", "Minority",
      "American Indian" = "American.Indian"
    )
  ),
  
  selectInput(
    inputId = "race_color",
    label = "Select color:",
    choices = c("Blue", "Black", "Red", "Orange", "Green")
  )
)

race_main_panel <- mainPanel(
  titlePanel("Arrests Over Time"),
  plotlyOutput(outputId = "race_plot")
)

interactive2_panel <- tabPanel(
  "Race",
  h1("Juvenile Arrests by Race"),
  race_sidebar,
  race_main_panel
)


# Ryan -----------------------

interactive3_panel <- tabPanel(
  "Interactive 3",
  h1("Ryan's Interactive")
)

summary_panel <- tabPanel(
  "Summary",
  h1("Summary")
)


ui <- navbarPage(
  "Juvenile Incarceration",
  intro_panel,
  interactive1_panel,
  interactive2_panel,
  interactive3_panel,
  summary_panel
)