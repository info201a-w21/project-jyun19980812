# This is app_server.R file.
library(shiny)
library(tidyverse)
library(maps)
library(plotly)

# Load the data
rates_of_resi_pl<- read.csv(file = "data/Juvenile Residential Placement.csv")
arrests <- read.csv("data/juv_offenses.csv", stringsAsFactors = F, check.names = F)
rates_by_race <- read.csv("data/arrest_rates_by_race.csv", check.names = F)

server <- function(input, output) {
  
}