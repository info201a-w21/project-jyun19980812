library(tidyverse)
rates_by_race <- read.csv("data/arrest_rates_by_race.csv", check.names = FALSE)

rates_by_race_long <- gather(
  rates_by_race,
  key = Race,
  value = Rates,
  -Year
)

aggregated_table <- rates_by_race_long %>% 
  group_by(Year) %>% 
  summarise(avg_of_races = round(mean(Rates, na.rm = T), digits = 0)) #%>% 

