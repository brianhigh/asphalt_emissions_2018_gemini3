Write an R script which creates a US states choropleth map with ggplot using data from [data.gov](https://catalog.data.gov/dataset/data-anthropogenic-secondary-organic-aerosol-and-ozone-production-from-asphalt-related-emi), specifically the file AP_2018_State_County_Inventory.xlsx, which can be found at this URL: https://pasteur.epa.gov/uploads/10.23719/1531683/AP_2018_State_County_Inventory.xlsx. Use the "Output - State" sheet and the columns State and "Total kg/person".

The color scale for "Total kg/person" should be: low values are dark green, medium are yellow/orange, and high values are red. State borders should be grey. The plot background should be white.

The script should save the map to a PNG file stored in a "plots" folder. The plot should mention the data source in the plot caption in the lower left corner of the plot margin. 

Include the code to conditionally download the data file if the file has not already been downloaded. Save the data file to a "data" folder. Use pacman::p_load() to load R packages. 

Your code should create the "data" and "plots" folders if they do not already exist. 

Include error handling in the code. Test and debug your code. When successful reading the data file, do not print informational messages provided by the read_excel function, so do not show "New names:" output, but do print a message when the file is successfully read. Suppress warnings when converting values to numeric.

Create a README.md that displays the map by linking to the PNG plot file. Save the implementation plan as plan.md. Create a tasks.md file for the task checklist used to implement the plan. Save the walkthrough as walkthrough.md. Create a .gitignore file to exclude VS Code or RStudio metadata files. Do not list the data and plots folders/files in the .gitignore as we want them in the repo.

In the README.md, cite the research paper associated with this dataset: "Anthropogenic secondary organic aerosol and ozone production from asphalt-related emissions" and link to its DOI at: https://doi.org/10.1039/D3EA00066D.

Link to all of the markdown (.md) files in the README.md and list all of these files in the project structure section of the README.md.
