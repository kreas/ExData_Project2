#-------------------------------------------------------------------------------
#
# Exploratory Data Analysis - Project 2
#
# Author: Timothy R. Warren
# GitHub: https://github.com/kreas/ExData_Project2
# File: plot1.R
#
# Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#
# Directions -------------------------------------------------------------------
#
# * Download the file from README.md and extract it to the root directory of
#   this project.
# * Source this file with `source('plot1.R')`
# * Once this script compeletes you can find the output in the project's root
#   Directiory with the name plot1.png
#
#-------------------------------------------------------------------------------

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Table

# Get the sum of emission by year
pm25.totals <- tapply(NEI$Emissions, INDEX = NEI$year, sum)

# Set the output options
png(file = "plot1.png", width = 480, height = 480, bg = "transparent")

# Plot the data. 
plot(names(pm25.totals), pm25.totals, 
     type = "l",
     xlab = "Year", 
     ylab = expression(PM[2.5] ~ "Emissions"),
     main = expression("Total Emissions from" ~ PM[2.5] ~ "by Year")
     )

# Close the file device
dev.off()
