library(tidyverse)
library(ggplot2)

rates_by_race <- read.csv("arrest_rates_by_race.csv", check.names = FALSE)

# Reshape data by gathering rates into a single feature
rates_by_race_long <- gather(
  rates_by_race,
  key = Race,
  value = Rates,
  -Year
)

# Create a line chart of rates of juvenile arrests by race and over time
ggplot(data = rates_by_race_long) +
  geom_line(
    mapping = aes(x = Year, y = Rates, color = Race)
  ) +

  labs(
    title = "Arrests Rates of Juveniles by Race (All Offenses)",
    x = "Year",
    y = "Rate of Arrests (per 100,000 Persons)",
    color = "Race"
  )