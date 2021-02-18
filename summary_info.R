# This is to create summary information in a list

library(tidyverse)

arrests <- read.csv("data/juv_offenses.csv", stringsAsFactors = F, check.names = F)
rates_by_race <- read.csv("data/arrest_rates_by_race.csv", check.names = FALSE)
rates_of_resi_pl<- read.csv(file = "data/Juvenile Residential Placement.csv")

# Calculate the proportion of juvenile offenses compared to all ages offenses
all_offenses <- arrests %>% 
  filter(`0 to 17` == max(`0 to 17`, na.rm = T)) %>% 
  pull(`0 to 17`)

top_3 <- arrests %>% 
  top_n(3, wt = `0 to 17`) %>% 
  arrange(-`0 to 17`)

leading_offense <- top_3[-c(1, 2),] %>% 
  pull(`0 to 17`)

prop_of_juveniles <- paste0(round((leading_offense / all_offenses) * 100, digits = 2), "%")
  
  


