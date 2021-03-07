#Load packages
library(tidyverse)
library(ggplot2)
library(maps)
library(mapproj)
library(styler)

# This chart was intended to show the information of the total juvenile 
# residential placement rate in U.S. varied by states in 2017. The residential 
# placement rate is the number of juvenile offenders in residential placement per
# 100,000 juveniles age 10 through the upper age of original juvenile court 
# jurisdiction in each state. In the data, we are able to see Wyoming having the
# highest rate, whereas Connecticut having the lowest rate.  

# Creating a table that has information about the total residential placement 
# rate of juveniles.
rates_of_resi_pl<- read.csv(file = "data/Juvenile Residential Placement.csv") %>%
  mutate(State = tolower(State.of.offense)) %>% 
  select(State, Total)

# Merge the residential placement rate data to the U.S. shapefile.
state_data <- map_data("state") %>%
  rename(State = region) %>%
  left_join(rates_of_resi_pl, by = "State")

# Define a minimalist theme for maps
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(), # remove axis lines
    axis.text = element_blank(), # remove axis labels
    axis.ticks = element_blank(), # remove axis ticks
    axis.title = element_blank(), # remove axis titles
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank() # remove border around plot
  )

# Creating a map that shows the total juvenile residential placement rate 
# in U.S. varied by states
data_of_map <- ggplot(state_data) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = Total),
    color = "brown",
    size = .1
  ) +
  coord_map() +
  labs(fill = "Residential Placement Rate") +
  scale_fill_continuous(limits = c(0, max(state_data$Total)), 
                        na.value = "white", low = "yellow", high = "red") +
  blank_theme +
  ggtitle("Juvenile Residential Placement Rates by States in 2017")

