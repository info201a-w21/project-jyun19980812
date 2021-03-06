# This is app.R file.

#Load packages
library(tidyverse)
library(maps)
library(plotly)
library(shiny)

# Load the data
rates_of_resi_pl<- read.csv(file = "data/Juvenile Residential Placement.csv")
arrests <- read.csv("data/juv_offenses.csv", stringsAsFactors = F, check.names = F)
rates_by_race <- read.csv("data/arrest_rates_by_race.csv", check.names = FALSE)

# Source the app_server and app_ui
source("app_server.R")
source("app_ui.R")

# Create a new `shinyApp()` using the above ui and server
shinyApp(ui = ui, server = server)