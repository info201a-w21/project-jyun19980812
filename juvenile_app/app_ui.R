# This is app_ui.R file.

library(shiny)

intro_panel <- tabPanel(
  "Introduction",
  h1("Introduction")
)

interactive1_panel <- tabPanel(
  "Interactive 1",
  h1("Kelly's Interactive")
)

interactive2_panel <- tabPanel(
  "Interactive 2",
  h1("Casey's Interactive")
)

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