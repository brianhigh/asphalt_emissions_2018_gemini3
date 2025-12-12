# Implementation Plan - Asphalt Emissions Choropleth Map

This plan outlines the steps to create an R script that visualizes asphalt emissions data on a U.S. map.

## Proposed Changes

### Project Structure
#### [NEW] .gitignore
- Exclude `.Rproj.user`, `.Rhistory`, `.RData`, `.vscode`.
- explicit inclusion/non-exclusion of `data/` and `plots/`.

#### [NEW] script.R
- Main analysis script.
- **Dependencies**: `pacman`, `tidyverse`, `readxl`, `usmap`, `here`, `scales`.
- **Data Loading**: 
  - Check if `data/AP_2018_State_County_Inventory.xlsx` exists. 
  - If not, download from `https://pasteur.epa.gov/uploads/10.23719/1531683/AP_2018_State_County_Inventory.xlsx`.
- **Processing**:
  - Read `Output - State` sheet.
  - Select `State` and `Total kg/person`.
  - Convert `Total kg/person` to numeric (suppress warnings).
  - Normalize state names for merging with `usmap` data.
- **Visualization**:
  - Use `usmap::plot_usmap()` as base.
  - Merge with emissions data.
  - `ggplot2` layers:
    - Geo layer with `linewidth` and grey borders.
    - `scale_fill_gradient2` or `scale_fill_gradientn` for Dark Green -> Yellow -> Red.
    - Theme tweaks: White background, no axis titles.
    - Labels: Title (2018), Subtitle, Caption (Source).
- **Output**:
  - Save to `plots/asphalt_emissions_map.png`.

#### [NEW] README.md
- Display the generated map.
- Citation.
- Links to project docs.
