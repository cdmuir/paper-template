source("r/header.R")

read_lines("raw-data/100m-men.txt") %>%
  map(str_trim, side = "both") %>%
  map(str_replace_all, pattern = "\\s{2,}", replacement = ",") %>%
  write_lines("processed-data/100m-men.csv")

read_file("processed-data/100m-men.csv") %>%
  str_replace(
    "Kolby Listenbee,USA,1h3,Eugene,10.06.2015",
    "Kolby Listenbee,USA,NA,1h3,Eugene,10.06.2015"
  ) %>%
  str_replace(
    "1899,10.05,Davidson Ezinwa,NGR,22.11.71,1,Bauchi,03.01.1990",
    "1899,10.05,NA,Davidson Ezinwa,NGR,22.11.71,1,Bauchi,03.01.1990"
  ) %>%
  str_replace(
    "1899,10.05,Joshua J. Johnson,USA,10.05.76,1r2,Abuja,17.05.2003",
    "1899,10.05,NA,Joshua J. Johnson,USA,10.05.76,1r2,Abuja,17.05.2003"
  ) %>%
  str_replace(
    "1899,10.05,\\+0.5,Abdul Hakim Sani Brown,JPN,06.03.99,Osaka,24.06.2017",
    "1899,10.05,+0.5,Abdul Hakim Sani Brown,JPN,06.03.99,NA,Osaka,24.06.2017"
  ) %>%
  str_replace(
    "1899,10.05,\\+1.3,Davon Demoss,USA,4h2,Austin,05.06.2019",
    "1899,10.05,+1.3,Davon Demoss,USA,NA,4h2,Austin,05.06.2019"
  ) %>%
  str_replace(
    "2141,10.06,\\+0.8,Bryand Rincher,USA,5,Austin,07.06.2019",
    "2141,10.06,+0.8,Bryand Rincher,USA,NA,5,Austin,07.06.2019"
  ) %>%
  str_replace(
    "2410,10.07,Abdul Aziz Zakari,GHA,02.09.76,2r2,Abuja,17.05.2003",
    "2410,10.07,NA,Abdul Aziz Zakari,GHA,02.09.76,2r2,Abuja,17.05.2003"
  ) %>%
  str_replace(
    "2715,10.08A,Mike Roberson,USA,25.03.56,1h2,Ciudad de México,08.09.1979",
    "2715,10.08A,NA,Mike Roberson,USA,25.03.56,1h2,Ciudad de México,08.09.1979"
  ) %>%
  str_replace(
    "2715,10.08,Raymond Stewart,JAM,18.03.65,1,Kingston,15.07.1988",
    "2715,10.08,NA,Raymond Stewart,JAM,18.03.65,1,Kingston,15.07.1988"
  ) %>%
  str_replace(
    "2715,10.08,Ato Boldon,TTO,30.12.73,1,Bridgetown,24.06.1995",
    "2715,10.08,NA,Ato Boldon,TTO,30.12.73,1,Bridgetown,24.06.1995"
  ) %>%
  str_replace(
    "2715,10.08,Keston Bledman,TTO,08.03.88,1,Arima,10.05.2014",
    "2715,10.08,NA,Keston Bledman,TTO,08.03.88,1,Arima,10.05.2014"
  ) %>%
  str_replace(
    "3016,10.09,Davidson Ezinwa,NGR,22.11.71,1s1,Bauchi,03.01.1990",
    "3016,10.09,NA,Davidson Ezinwa,NGR,22.11.71,1s1,Bauchi,03.01.1990"
  ) %>%
  write_file("processed-data/100m-men.csv")

m100 <- read_csv("processed-data/100m-men.csv", col_types = cols(
  rank = col_integer(),
  time_s = col_character(),
  wind = col_character(),
  country = col_character(),
  name = col_character(),
  birthdate_DDMMYY = col_character(),
  place = col_character(),
  location = col_character(),
  date_DDMMYY = col_character()
)) %>%
  mutate(
    time_s = as.numeric(str_remove_all(time_s, "[[:alpha:]]")),
    wind = as.numeric(str_remove(wind, "±")),
    birthdate = dmy(str_replace(birthdate_DDMMYY, 
                            "^([0-9]{2}.[0-9]{2}.)([0-9]{2})$", "\\119\\2")),
    date = dmy(date_DDMMYY),
    age = date - birthdate, 
    d = day(birthdate),
    m = month(birthdate),
    y = year(birthdate),
    y = ifelse(age > (50 * 365), y + 100, y),
    d = str_pad(d, 2, pad = "0"),
    m = str_pad(m, 2, pad = "0"),
    birthdate = dmy(str_c(d, m, y)),
    age = date - birthdate,
    event = "100m",
    sex = "male"
  ) %>%
  select(event, sex, rank, time_s, wind, name, country, birthdate, place, location, date, age) %>%
  write_csv("processed-data/100m-men.csv")

