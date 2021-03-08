library(tidyverse)
library(ggplot2)
library(scales)

arrests <- read.csv("data/juv_offenses.csv", stringsAsFactors = F, check.names = F)

# Get the top ten offenses excluding the total and other offenses
top_10 <- arrests %>%
  top_n(12, wt = `0 to 17`) %>%
  arrange(-`0 to 17`)

top_10 <- top_10[-c(1, 2), ]

# Get the most frequent juvenile offense type
leading_offense <- top_10 %>%
  filter(`0 to 17` == max(`0 to 17`)) %>%
  pull(Offenses)

leading_num <- top_10 %>%
  filter(`0 to 17` == max(`0 to 17`)) %>%
  pull(`0 to 17`)

# Get the second most frequent juvenile offense type
second_highest <- top_10[-1, ] %>%
  filter(`0 to 17` == max(`0 to 17`)) %>%
  pull(Offenses)

second_num <- top_10[-1, ] %>%
  filter(`0 to 17` == max(`0 to 17`)) %>%
  pull(`0 to 17`)

# Plot a bar graph of the top juvenile offenses
bar_chart <- ggplot(data = top_10) +
  geom_col(mapping = aes(x = Offenses, y = `0 to 17`)) +
  scale_y_continuous(labels = comma, n.breaks = 10) +
  labs(
    title = "Top 10 Juvenile Arrests Offenses in 2019",
    x = "Offense Type",
    y = "Number of Offenses"
  ) +
  coord_flip()
