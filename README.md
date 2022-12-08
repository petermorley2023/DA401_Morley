# Hurricanes that have Hit the Caribbean: Time Series & Location Analysis

*Author*: Peter Morley

## Introduction
This file serves the purpose of file documentation and as a README for the files in this GitHub. The project that I conducted was regarding hurricane analysis with a focus on time series and location analysis. Within this folder, you can find files regarding the data that I collected and used, code, as well as other important documents. The version of R used for the code is version 4.2.1. The version Python used for the location code was Python 3 which was used in a Jupyter Notebook. All other files are PDFs or CSVs so they should be accessible from any computer. The types of analysis conducted were time-series analysis using graphs, one-way ANOVA tests, and summary statistics. Additionally, I will also use quadrat count analysis as well as the use of maps to do my locaiton analysis. 

## Needed Packages
1. R: dplyr (v1.0.10), ggplot2 (v3.4), grid (v4.3.0), pracma (v2.4.2)
2. Python3/Jupyter Notebook: numpy (v1.23), pandas (v1.5.1), seaborn (v0.12.1), matplotlib (v3.6.0), contextily, pointpats (v2.1.1)


## Data
1. File Name: caribbean_hurricanes.csv (2452 x 13)
* This file is the filtered-down data that includes all hurricanes that fit my inclusion criterion (latitude & longitude limits) for the Caribbean. 

2. File Name: clean_all_hurricanes.csv (52884 x 12)
* This file includes all hurricane data provided by the NOAA that I have cleaned and collected. This data ranges from 1851 through 2021 and has not been filtered down so all the data is present. 

3. File Name: hurricane_counts.csv (172 x 6)
* This file includes data regarding the total yearly hurricane counts within the Caribbean (1851 – 2021). This was created through code in the Project_Code.R file so you do not need to download this file unless you want to inspect it.

4. File Name: yearly_pressures.csv (30 x 3)
* This file includes data regarding the average minimum pressure and the minimum pressure within the Caribbean (1992 – 2021). This was created through code in the Project_Code.R file so you do not need to download this file unless you want to inspect it.

5. File Name: yearly_winds.csv (171 x 3)
* This file includes data regarding the average and maximum yearly wind speeds in knots for the hurricanes within the Caribbean (1992 – 2021). This was created through code in the Project_Code.R file so you do not need to download this file unless you want to inspect it.

6. NHC Hurricane Reports
* I decided not to attach all the hurricane reports that I collected data from to this repository since there are a total of 123 reports. Instead you can find the ones that were collected from the following URL, https://www.nhc.noaa.gov/data/tcr/index.php?season=2021&basin=atl. The reports collected were from years 2016 through 2021.

7. Hurricane Data (1851 - 2015)
* The data that I used for the years 1851-2015 was found on Kaggle and published there by the NOAA. The data can be found here: https://www.kaggle.com/datasets/noaa/hurricane-database

## Code
1. File Name: Project_Code.R
* This file contains all the code which I used in R to manipulate, visualize, and analyze the wind speed and pressure over time for hurricanes. 

2. File Name: Location_Data.ipynb
* This file contains all the code which I used in Jupyter Notebooks/Python3 to manipulate, visualize, and analyze the location data for hurricanes. 

## Important Documents
1. File Name: Final Paper.pdf
* This file is my research paper which contains all information regarding domain review, methods of analysis, results, and conclusion. 

2. File Name: Executive_Summary.pdf
* This file is my executive summary which summarizes my project as a whole. It includes a summary of the introduction, data, methods, results, and recommendations found in the Final Paper.pdf file.


