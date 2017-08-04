library(tidyverse)

cent_quake <- read_csv(
  "https://earthquake.usgs.gov/data/centennial/centennial_Y2K.CAT",
  col_names = FALSE) %>%
  separate(X1, into = c("icat", "asol", "isol", "yr", "mon", "day", "hr", "min",
                        "sec",  "glat", "glon", "dep",  "greg", "ntel",
                        "mag1", "msc1", "mdo1", "mag2", "msc2", "mdo2",
                        "mag3", "msc3", "mdo3", "mag4", "msc4", "mdo4",
                        "mag5", "msc5", "mdo5", "mag6", "msc6", "mdo6",
                        "mag7", "msc7", "mdo7", "mag8", "msc8", "mdo8"),
          sep = c(5, 6, 11, 15, 18, 21, 25, 28, 34, 43, 51, 57, 61, 65, 
                  69, 72, 78, 82, 85, 91, 95, 98, 104, 108, 111, 117,
                  121, 124, 130, 134, 137, 143, 147, 150, 156, 160, 163))

num_cols <- c("yr", "mon", "day", "hr", "min", "sec", "glat", "glon", "dep", "greg", "ntel",
              "mag1", "mag2", "mag3", "mag4", "mag5", "mag6", "mag7", "mag8")

cent_quake <- cent_quake %>%
  mutate_each(funs(as.numeric), num_cols)

ggplot(cent_quake, aes(x = yr)) + geom_histogram()
ggplot(cent_quake, aes(x = mag1)) + geom_histogram()