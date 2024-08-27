# GeoSampling-Mapping-Clustering
This project consists of a set of scripts designed for geospatial data analysis, specifically focused on sampling, mapping, and clustering geospatial data. The scripts are built using R and are designed to process atmospheric pressure data collected at different geographical locations.

## Table of Contents

1. [Introduction](#introduction)
2. [Project Structure](#project-structure)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Script Details](#script-details)
    - [Sampling Script](#sampling-script)
    - [Mapping Script](#mapping-script)
    - [Clustering Script](#clustering-script)
6. [Outputs](#outputs)
7. [Contributing](#contributing)
8. [Contact](#contact)

## Introduction

The goal of this project is to perform geospatial data analysis on atmospheric pressure data collected from different locations. The project includes three main scripts:

- **Sampling Script**: Samples the data at specified intervals to reduce redundancy.
- **Mapping Script**: Visualizes the data by creating an interactive map with interpolated pressure values.
- **Clustering Script**: Groups the data points into clusters based on geographical proximity.

These scripts are useful for geospatial data analysts, meteorologists, and environmental researchers who want to analyze and visualize atmospheric pressure data effectively.

## Project Structure

```plaintext
Geospatial-Data-Analysis/
│
├── data/
│   └── sampled_data.csv    # Example CSV file with sampled data
│
├── outputs/
│   ├── interactive_map.html # Output from the mapping script
│   ├── clusters_plot.png    # Output from the clustering script
│   └── clustered_data.csv   # CSV file with data and cluster IDs
│
├── scripts/
│   ├── sampling_script.R    # Script for sampling data
│   ├── mapping_script.R     # Script for creating an interactive map
│   └── clustering_script.R  # Script for clustering data
│
└── README.md                # Project documentation
```

## Installation

To run these scripts, you need to have R installed along with the following R packages:

- `dplyr`
- `geosphere`
- `leaflet`
- `gstat`
- `sp`
- `sf`
- `ggplot2`
- `cluster`
- `png`
- `htmlwidgets`

### Step 1: Install R

If you don't have R installed, you can download it from the official [R project website](https://cran.r-project.org/). Follow the installation instructions for your operating system.

### Step 2: Install Required R Packages

Once R is installed, you can install the required packages by running the following command in the R console:

```R
install.packages(c("dplyr", "geosphere", "leaflet", "gstat", "sp", "sf", "ggplot2", "cluster", "png", "htmlwidgets"))
```

### Step 3: Clone the Repository


Clone this repository to your local machine using the following command:

```
git clone https://github.com/yourusername/Geospatial-Data-Analysis.git
```

Replace yourusername with your GitHub username.

### Step 4: Navigate to the Project Directory

Navigate to the project directory where the scripts and data files are located:

```
cd Geospatial-Data-Analysis
```

### Step 5: Run the Scripts

You can now run the scripts using R. Open the R scripts in an R editor (e.g., RStudio) and execute them as needed. Follow the usage instructions provided in the Usage section.

## Usage

1. **Sampling Script**: Run the `sampling_script.R` to sample the input data. It reads a CSV file with raw data and outputs a sampled version with reduced duplication.

2. **Mapping Script**: Run the `mapping_script.R` after sampling the data. This script generates an interactive map showing interpolated atmospheric pressure values.

3. **Clustering Script**: Run the `clustering_script.R` to perform k-means clustering on the sampled data. The script generates a plot showing the clusters and saves the clustered data to a CSV file.

## Script Details

### Sampling Script

- **Purpose**: Convert data to a spatial format and sample every 10 meters along the road to reduce duplication.
- **Libraries Used**: `dplyr`, `geosphere`
- **Key Functionality**:
  - Reads and preprocesses data.
  - Converts timestamps for accurate time handling.
  - Uses the Haversine formula to calculate distances and sample data.
- **Output**: A sampled dataset saved as a CSV file.

### Mapping Script

- **Purpose**: Create an interactive map displaying interpolated pressure values.
- **Libraries Used**: `dplyr`, `leaflet`, `gstat`, `sp`
- **Key Functionality**:
  - Reads the sampled data and converts it to a spatial object.
  - Uses Inverse Distance Weighting (IDW) for interpolation.
  - Visualizes the interpolated data on a Leaflet map.
- **Output**: An HTML file containing the interactive map.

### Clustering Script

- **Purpose**: Perform k-means clustering on geospatial data.
- **Libraries Used**: `dplyr`, `ggplot2`, `sf`, `cluster`, `png`
- **Key Functionality**:
  - Reads sampled data and prepares it for clustering.
  - Applies k-means clustering to group data points.
  - Visualizes clusters with ggplot2 and calculates silhouette scores for validation.
- **Output**: A plot saved as a PNG file and a CSV file with cluster IDs.

## Outputs

The following outputs are generated by the scripts:

- **Sampled Data CSV**: Reduced data sampled at 10-meter intervals.
- **Interactive Map (HTML)**: Visual representation of atmospheric pressure data, created by the mapping script.
- **Cluster Plot (PNG)**: A scatter plot showing clusters, created by the clustering script.
- **Clustered Data CSV**: Data with assigned cluster IDs for further analysis, created by the clustering script.

## Contributing

If you'd like to contribute to this project, please fork the repository and use a feature branch. Pull requests are warmly welcome. Make sure to follow these steps:

1. Fork the repository.
2. Create a new feature branch (`git checkout -b feature-branch-name`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch-name`).
5. Open a pull request.

## Contact

For questions, feedback, or support, please contact me at [![Email](https://img.shields.io/badge/Email-blue?style=flat&logo=gmail)](mailto:samaneh.shirinnezhad@gmail.com).




