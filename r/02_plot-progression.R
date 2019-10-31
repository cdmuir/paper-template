source("r/header.R")

m100 <- read_csv("processed-data/100m-men.csv", col_types = cols(
  event = col_character(),
  sex = col_character(),
  rank = col_integer(),
  time_s = col_double(),
  wind = col_double(),
  country = col_character(),
  name = col_character(),
  birthdate = col_date(),
  place = col_character(),
  location = col_character(),
  date = col_date()
)) 

m100_progression <- m100 %>%
  arrange(date) %>%
  mutate(record = cummin(time_s)) %>%
  mutate(record_change = c(-1, diff(record))) %>%
  filter(record_change < 0) %>%
  select(-record_change)

ggplot(m100_progression, aes(date, time_s)) +
  geom_line(color = "tomato") +
  geom_point(shape = 21, color = "white", fill = "black", size = 3, stroke = 2) +
  xlab("Date") +
  ylab("Time [s]") +
  theme_cowplot()

ggsave("figures/m100-progression.pdf", width = 4, height = 4)
