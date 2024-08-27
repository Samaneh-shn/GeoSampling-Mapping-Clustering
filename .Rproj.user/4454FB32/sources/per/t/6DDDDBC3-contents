#install packages using the following line of code
#install.packages("packgae_name")

#Load packages
library(dplyr)
library(ggplot2)
library(sf)
library(cluster)
library(gridExtra) # for better visualization of clusters 
library(png) # for displaying images
library(factoextra) # for visualizing clustering results


# Load the data
data <- read.csv("~/Desktop/Sensor_Measurements/sampled_data.csv")


# Rename columns for consistency
colnames(data) <- c("timestamp", "pressure", "latitude", "longitude")


# Convert timestamp to POSIXct
data$timestamp <- as.POSIXct(data$timestamp, format="%H:%M:%S", tz="UTC")

coordinates <- data.frame(longitude = data$longitude, latitude = data$latitude)

# Define the range of possible cluster numbers
cluster_range <- 2:10
silhouette_scores <- numeric(length(cluster_range))
names(silhouette_scores) <- as.character(cluster_range)

# Loop through each possible number of clusters
set.seed(123) 
for (k in cluster_range) {
  # Perform k-means clustering
  kmeans_result <- kmeans(coordinates, centers = k)
  
  # Compute silhouette scores
  distance_matrix <- dist(coordinates)
  sil_scores <- silhouette(kmeans_result$cluster, distance_matrix)
  
  # The average silhouette score for each k
  silhouette_scores[k] <- mean(sil_scores[, "sil_width"])
}

# Display all average silhouette scores
print(silhouette_scores)


# Convert results to a data frame for plotting
results_df <- data.frame(ClusterCount = names(silhouette_scores), 
                         AverageSilhouette = silhouette_scores)

# Plot average silhouette scores against cluster count
plot <- ggplot(results_df, aes(x = ClusterCount, y = AverageSilhouette)) +
  geom_line(group = 1, colour = "blue") +
  geom_point(aes(color = ClusterCount), size = 3) +
  labs(title = "Average Silhouette Scores by Cluster Count",
       x = "Number of Clusters",
       y = "Average Silhouette Score") +
  theme_minimal()

# Print the plot
print(plot)


# Set the optimal number of clusters based on previous analysis
optimal_clusters <- 3
cat("Optimal number of clusters based on prior analysis:", optimal_clusters, "\n")


# Perform k-means clustering with the chosen optimal number of clusters
final_kmeans <- kmeans(coordinates, centers = optimal_clusters)


# Add cluster information to the data
data$cluster <- final_kmeans$cluster


# Plotting the clusters
cluster_plot <- ggplot(data, aes(x = longitude, y = latitude, color = factor(cluster))) +
  geom_point(alpha = 0.8, size = 3) +
  ggtitle(paste("Map of Clusters with K =", optimal_clusters)) +
  labs(color = "Cluster") +
  theme_minimal()
# Save and display the cluster plot
ggsave("optimal_clusters.png", plot = cluster_plot, width = 8, height = 6, dpi = 300)
display_img <- grid::rasterGrob(readPNG("optimal_clusters.png"), interpolate = TRUE)
gridExtra::grid.arrange(display_img)


# Compute and plot silhouette scores for the chosen optimal number of clusters
optimal_sil_scores <- silhouette(final_kmeans$cluster, distance_matrix)
sil_plot <- fviz_silhouette(optimal_sil_scores)
print(sil_plot)
ggsave("silhouette_scores.png", plot = sil_plot, width = 8, height = 6, dpi = 300)


# Save the data with cluster assignments
write.csv(data, "clustered_data.csv", row.names = FALSE)
