library(tidyverse)
library(leaflet)

download.file(
  "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv",
  "data-raw/last_month_quake.csv")

raw <- read.csv("data-raw/last_month_quake.csv")

last_month_quake <- raw %>% 
  filter(type == "earthquake") %>%
  select(latitude, longitude, mag, depth) %>%
  mutate(depthtype = ifelse(depth > 33.0, "deep", "shallow")) %>%
  arrange(desc(mag))



ggplot(last_month_quake, aes(x = mag)) + geom_histogram()
ggplot(shallow_quakes, aes(x = mag)) + geom_histogram()


add_quake <- function(quakedata, rownum, leafletmap) {
  x <- as.character(last_month_quake$mag[rownum])
  
  leafletmap <- addMarkers(leafletmap, 
                           lat = quakedata$latitude[rownum],
                           lng = quakedata$longitude[rownum],
                           popup = x)
}

m <- leaflet() %>% addTiles()

m <- add_quake(last_month_quake, 1:20, m)

print(m)