# Loading package
library(tidyverse)

# Calling csv files
arrests <- read.csv("data/juv_offenses.csv", stringsAsFactors = F, check.names = F)
rates_by_race <- read.csv("data/arrest_rates_by_race.csv", check.names = FALSE)
rates_of_resi_pl<- read.csv(file = "data/Juvenile Residential Placement.csv")

# Calculate the proportion of the leading juvenile offense
# compared to all offenses committed by juveniles from age 0-17
all_offenses <- arrests %>% 
  filter(`0 to 17` == max(`0 to 17`, na.rm = T)) %>% 
  pull(`0 to 17`)

top_3 <- arrests %>% 
  top_n(3, wt = `0 to 17`) %>% 
  arrange(-`0 to 17`)

leading_offense <- top_3[-c(1, 2),] %>% 
  pull(`0 to 17`)

prop_of_juveniles <- paste0(round((leading_offense / all_offenses) * 100, digits = 2), "%")
  
# Calculate the race with the highest average arrest rate and the race with the 
# lowest average arrest rate

# Reshape data by gathering rates into a single feature
rates_by_race_long <- gather(
  rates_by_race,
  key = Race,
  value = Rates,
  -Year
)

# Calculate average rates of arrest for each race
average_per_race <- rates_by_race_long %>% 
  group_by(Race) %>% 
  summarise(average_rate = mean(Rates, na.rm = T))

# Identify the race with highest average rate
highest_average <- average_per_race %>% 
  filter(average_rate == max(average_rate, na.rm = T)) %>% 
  pull(Race)

# Identify the race with lowest average rate
lowest_average <- average_per_race %>% 
  filter(average_rate == min(average_rate, na.rm = T)) %>% 
  pull(Race)

# calculate the state with the highest juvenile residential placement rate and
# the lowest juvenile residential placement rate.
# Select the column of interest
total_rates <- rates_of_resi_pl %>% 
  select(State.of.offense, Total)

# Identify the state with highest juvenile residential placement rate
highest_resi_pl_rate <- total_rates %>% 
  filter(Total == max(Total)) %>% 
  pull(State.of.offense)

# Identify the state with lowest juvenile residential placement rate
lowest_resi_pl_rate <- total_rates %>% 
  filter(Total == min(Total)) %>% 
  pull(State.of.offense)

# Taking the summary information into the list.
summary_info <- list()
summary_info$prop_of_juveniles <- prop_of_juveniles
summary_info$highest_average <- highest_average
summary_info$lowest_average <- lowest_average
summary_info$highest_resi_pl_rate <- highest_resi_pl_rate
summary_info$lowest_resi_pl_rate <- lowest_resi_pl_rate
