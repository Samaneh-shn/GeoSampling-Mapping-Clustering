#install packages using the following line of code
#install.packages("packgae_name")

# Load the packages
library(dplyr)
library(geosphere)


# Read the data
data <- read.csv("~/Desktop/Sensor_Measurements/Barometer_withlocation.csv")
#if Sensor_Measurements folder is added in another drive than desktop
#make sure to change the file directory accordingly


# Clean column names: Remove unnamed or improperly named columns and correct names
colnames(data) <- make.names(colnames(data), unique = TRUE)


data <- data[, !colnames(data) %in% c("NA", "X")]  # Remove columns named 'NA' 
#or starting with 'X' which often denote unnamed columns


# Rename columns for consistency
colnames(data) <- c("timestamp", "pressure", "latitude", "longitude")


# Convert timestamp to POSIXct
data$timestamp <- as.POSIXct(data$timestamp, format="%H:%M:%S", tz="UTC")


# Function to sample data at equal distances
sample_at_equal_distances <- function(data, distance = 10) {
  # Arrange data by timestamp
  data <- data %>% arrange(timestamp)
  
  # Initialize sampled data with the first observation
  sampled_data <- data[1, ]
  
  for (i in 2:nrow(data)) {
    last_sampled_point <- sampled_data[nrow(sampled_data), ]
    current_point <- data[i, ]
    
    # Check for NA values in coordinates
    if (is.na(last_sampled_point$longitude) | is.na(last_sampled_point$latitude) |
        is.na(current_point$longitude) | is.na(current_point$latitude)) {
      next  # Skip this iteration if there are NA coordinates
    }
    
    # Calculate the distance between the last sampled point and the current point
    dist <- distHaversine(c(last_sampled_point$longitude, last_sampled_point$latitude), 
                          c(current_point$longitude, current_point$latitude))
    
    # Debugging output (optional, can be commented out after confirming it works)
    print(paste("Distance between points:", dist))
    
    # If the distance is greater than or equal to the specified distance, add the current point to sampled data
    if (dist >= distance) {
      sampled_data <- rbind(sampled_data, current_point)
    }
  }
  
  return(sampled_data)
}



# Sample data at 10 meters
sampled_data <- sample_at_equal_distances(data, 10)



# Save the sampled data
write.csv(sampled_data, "~/Desktop/Sensor_Measurements/sampled_data.csv", row.names = FALSE)
