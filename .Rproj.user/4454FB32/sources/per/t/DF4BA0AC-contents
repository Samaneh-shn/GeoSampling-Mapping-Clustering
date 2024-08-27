#install packages using the following line of code
#install.packages("packgae_name")

# Load the packages
library(dplyr)
library(leaflet)
library(gstat)
library(sp)


# Read the data
data <- read.csv("~/Desktop/Sensor_Measurements/sampled_data.csv")


# Rename columns for consistency
colnames(data) <- c("timestamp", "pressure", "latitude", "longitude")


# Create a spatial data frame
coordinates(data) <- ~longitude+latitude


# Create an interpolation grid
bbox <- bbox(data)
grd <- expand.grid(
  longitude = seq(from = bbox[1, 1], to = bbox[1, 2], by = 0.001),
  latitude = seq(from = bbox[2, 1], to = bbox[2, 2], by = 0.001)
)
coordinates(grd) <- ~longitude+latitude
gridded(grd) <- TRUE


# Perform IDW interpolation
idw_result <- idw(pressure ~ 1, data, grd)


# Convert to a data frame for leaflet
idw_df <- as.data.frame(idw_result)
colnames(idw_df) <- c("longitude", "latitude", "pressure")


# High contrast color palette
high_contrast_palette <- colorRampPalette(c("navy", "blue", "green", "yellow", "red", "darkred"))(100)

# Create the color function
colorFunc <- colorNumeric(palette = high_contrast_palette, domain = idw_df$pressure)

# Update the leaflet color mapping and add legend
map <- leaflet(data = idw_df) %>%
  addTiles() %>%  # Add default OpenStreetMap tiles
  addCircleMarkers(~longitude, ~latitude, 
                   color = ~colorFunc(pressure), 
                   radius = 5, 
                   popup = ~paste("Pressure:", pressure, "hPa")) %>%
  addLegend("bottomright", pal = colorFunc, values = ~pressure,
            title = "Pressure (hPa)",
            labFormat = labelFormat(suffix = " hPa"))

# Save the map as an HTML widget
htmlwidgets::saveWidget(map, "pressure_map.html", selfcontained = TRUE)