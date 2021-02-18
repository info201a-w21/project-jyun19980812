# This is to create summary information in a list

library(tidyverse)

arrests <- read.csv("data/juv_offenses.csv", stringsAsFactors = F, check.names = F)
rates_by_race <- read.csv("data/arrest_rates_by_race.csv", check.names = FALSE)
rates_of_resi_pl<- read.csv(file = "data/Juvenile Residential Placement.csv")

# Calculate the proportion of juvenile offenses compared to all ages offenses
prop_of_juveniles <- arrests %>% 
  
  


