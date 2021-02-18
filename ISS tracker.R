library(geosphere)
library(rjson)
library(ggplot2)


iss_file <- paste0("http://api.open-notify.org/iss-now.json")
iss <- fromJSON(file = iss_file)
iss <- as.data.frame(iss)
iss$message <- NULL
iss_df <- data.frame(iss_position = c(iss$iss_position.latitude, iss$iss_position.longitude),
                     timestamp = iss$timestamp,
                     latitude = iss$iss_position.latitude,
                     longitude = iss$iss_position.longitude)
iss_df$timestamp <- as.POSIXct(iss_df$timestamp, origin="1970-01-01")

iss_df$iss_position <- as.numeric(iss_df$iss_position)
iss_df$latitude <- as.numeric(iss_df$latitude)
iss_df$longitude <- as.numeric(iss_df$longitude)

#ISS plot

world <- map_data("world")

ggplot() +
  geom_map(
    data = world, map = world,
    aes(long, lat, map_id = region),
    color = "antiquewhite2", fill = "antiquewhite2", size = 0.1
  ) + 
  ggtitle("Current Position International Space Station") +
  xlab("Longitude") + ylab("Latitude") +
  theme(plot.title = element_text(color="black", size=12, face="bold", hjust = 0.5),
        axis.title.x = element_text(color="black", size=9, face="bold"),
        axis.title.y = element_text(color="black", size=9, face="bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "aliceblue")
        ) +
  geom_point(iss_df, mapping = aes(x = longitude,  y = latitude),
             shape=13, fill="blue", color="darkred", size=3) 
  

###############################################################################


