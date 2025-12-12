# Project Walkthrough

This document recounts the steps taken to build the Asphalt Emissions Choropleth Map.

## 1. Project Setup
- Created a workspace folder `asphalt_emissions_2018_gemini3`.
- Initialized `.gitignore` to exclude standard R temporary files and VS Code settings, while ensuring `data/` and `plots/` are tracked if desired (or just not explicitly ignored).

## 2. Planning
- Drafted a `plan.md` to outline the technical approach:
    - Use `pacman` for dependency management.
    - Use `curl` for robust file downloading.
    - Use `readxl` for reading the specific Excel sheet.
    - Use `usmap` and `ggplot2` for visualization.
- Created `tasks.md` to track progress.

## 3. Implementation (`script.R`)
The R script performs the following sequentially:
1.  **Setup**: Loads `tidyverse`, `readxl`, `usmap`, `scales`, and `curl`. Creates `data/` and `plots/` directories.
2.  **Data Retrieval**: Checks for the existence of `AP_2018_State_County_Inventory.xlsx`. If missing, downloads it from the EPA Pasteur server in binary mode.
3.  **Data Cleaning**: 
    - Reads the "Output - State" sheet.
    - Selects relevant columns: `State` and `Total kg/person`.
    - Converts the emissions value to numeric, suppressing warnings for non-numeric artifacts.
    - Normalizes state names to lowercase for robust merging with map data.
4.  **Visualization**:
    - Generates a base US map using `plot_usmap`.
    - Applies a color gradient: Dark Green (Low) -> Yellow (Medium) -> Red (High).
    - Removes axis labels and applies a clean white theme.
    - Adds title, subtitle, and source caption.
5.  **Output**: Saves the high-resolution PNG to `plots/asphalt_emissions_map.png`.

## 4. Documentation
- Created `README.md` to showcase the final map and link to the data source.
- Generated this `walkthrough.md` to explain the process.

## 5. Execution
- Ran the script successfully, verifying that the data was downloaded, processed, and mapped without errors.
