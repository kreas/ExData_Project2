#-------------------------------------------------------------------------------
#
# Exploratory Data Analysis - Project 2
#
# Author: Timothy R. Warren
# GitHub: https://github.com/kreas/ExData_Project2
# File: plot3.R
#
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.
#
# Directions -------------------------------------------------------------------
#
# * Download the file from README.md and extract it to the root directory of
#   this project.
# * Source this file with `source('plot3.R')`
# * Once this script compeletes you can find the output in the project's root
#   Directiory with the name plot3.png
#
#-------------------------------------------------------------------------------

# Load ggPlot2
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Table

# Get the sum of emission by year
baltimore     <- subset(NEI, NEI$fips == 24510)
pm25.totals   <- tapply(baltimore$Emissions, INDEX = baltimore$year, sum)

# Set the output options
png(file = "plot3.png", width = 640, height = 480, bg = "transparent")

# Plot the data. 
g <- ggplot(data = baltimore, aes(factor(year), Emissions, fill = type)) 
g <- g + geom_bar(stat="identity", position="dodge") +
          xlab("Year") +
          ylab("Emissions") +
          ggtitle(expression(PM[2.5] ~ "Emissions for Baltimore (1999-2008)"))

print(g) # Print to the device.

# Close the file device
dev.off()
