
# Asphalt Emissions Mapping Project
# Author: Antigravity
# Date: 2025-12-12

# 1. Setup and Configuration ----------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, readxl, usmap, here, scales, curl)

# Define paths
data_dir <- here::here("data")
plots_dir <- here::here("plots")
data_file <- file.path(data_dir, "AP_2018_State_County_Inventory.xlsx")
plot_file <- file.path(plots_dir, "asphalt_emissions_map.png")

# Create directories if they don't exist
if (!dir.exists(data_dir)) dir.create(data_dir, recursive = TRUE)
if (!dir.exists(plots_dir)) dir.create(plots_dir, recursive = TRUE)

# 2. Data Acquisition -----------------------------------------------------
data_url <- "https://pasteur.epa.gov/uploads/10.23719/1531683/AP_2018_State_County_Inventory.xlsx"

if (!file.exists(data_file)) {
    message("Downloading data file...")
    tryCatch(
        {
            curl::curl_download(data_url, data_file, mode = "wb")
            message("Download complete.")
        },
        error = function(e) {
            stop("Failed to download data: ", e$message)
        }
    )
} else {
    message("Data file already exists.")
}

# 3. Data Processing ------------------------------------------------------
message("Reading and processing data...")

# Read specific sheet
tryCatch(
    {
        raw_data <- readxl::read_excel(
            data_file,
            sheet = "Output - State",
            .name_repair = "unique_quiet" 
        )
        
        message("Data read successfully.")
    },
    error = function(e) {
        stop("Failed to read Excel file: ", e$message)
    }
)

# Extract and clean
clean_data <- raw_data %>%
    select(State, `Total kg/person`) %>%
    mutate(
        # Suppress NAs introduced by coercion warnings
        `Total kg/person` = suppressWarnings(as.numeric(`Total kg/person`)),
        # Normalize state names for matching
        state = tolower(State) 
    ) %>%
    # Remove rows where conversion failed or state is missing
    filter(!is.na(`Total kg/person`), !is.na(state))

# 4. Visualization --------------------------------------------------------
message("Generating map...")

# usmap's plot_usmap expects a 'state' or 'fips' column. 
# It handles case-insensitive matching for state names usually, 
# but providing a 'state' column is good practice.
# We will rename our cleaned column to match what plot_usmap looks for if needed,
# or pass it explicitly.

# The prompt asks for:
# Low: Dark Green, Medium: Yellow, High: Red
# Borders: Grey, Background: White

map_plot <- plot_usmap(data = clean_data, values = "Total kg/person", color = "grey", linewidth = 0.5) +
    scale_fill_gradientn(
        colors = c("darkgreen", "yellow", "red"),
        name = "Total kg/person",
        label = scales::comma
    ) +
    labs(
        title = "Asphalt Emissions by State (2018)",
        subtitle = "Per capita emissions (Total kg/person)",
        caption = "Source: EPA AP 2018 State County Inventory\nDOI: 10.1039/D3EA00066D"
    ) +
    theme(
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        legend.position = "right",
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12),
        plot.caption = element_text(size = 8, hjust = 0),
        # Remove axis elements
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()
    )

# 5. Output ---------------------------------------------------------------
message("Saving plot...")

ggsave(
    filename = plot_file,
    plot = map_plot,
    width = 10,
    height = 7,
    dpi = 300,
    bg = "white" # Explicitly set background for PNG
)

message("Success! Map saved to: ", plot_file)
