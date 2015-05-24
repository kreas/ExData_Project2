#-------------------------------------------------------------------------------
#
# Exploratory Data Analysis - Project 2
#
# Author: Timothy R. Warren
# GitHub: https://github.com/kreas/ExData_Project2
# File: plot2.R
#
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.
#
# Directions -------------------------------------------------------------------
#
# * Download the file from README.md and extract it to the root directory of
#   this project.
# * Source this file with `source('plot2.R')`
# * Once this script compeletes you can find the output in the project's root
#   Directiory with the name plot2.png
#
#-------------------------------------------------------------------------------

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Table

# Get the sum of emission by year
baltimore <- subset(NEI, NEI$fips == 24510)
pm25.totals <- tapply(baltimore$Emissions, INDEX = baltimore$year, sum)

# Set the output options
png(file = "plot2.png", width = 480, height = 480, bg = "transparent")

# Plot the data. 
barplot(pm25.totals, 
     xlab = "Year", 
     ylab = expression(PM[2.5] ~ "Emissions"),
     main = expression(PM[2.5] ~ "Emissions for Baltimore, MD (1999-2008)")
)

# Close the file device
dev.off()
