#-------------------------------------------------------------------------------
#
# Exploratory Data Analysis - Project 2
#
# Author: Timothy R. Warren
# GitHub: https://github.com/kreas/ExData_Project2
# File: plot5.R
#
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips=="06037").
# Which city has seen greater changes over time in motor vehicle emissions?
#
# Directions -------------------------------------------------------------------
#
# * Download the file from README.md and extract it to the root directory of
#   this project.
# * Source this file with `source('plot6.R')`
# * Once this script completes you can find the output in the project's root
#   Directory with the name plot6.png
#
#-------------------------------------------------------------------------------

# Load ggPlot2
library(ggplot2)
library(plyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Table

# Subset the data to the Baltimore region.
SCC.onRoad            <- subset(SCC, Data.Category == 'Onroad')
NEI.onRoad <- subset(NEI, SCC %in% SCC.onRoad$SCC)
NEI.onRoad <- subset(NEI.onRoad, fips == "06037" | fips =="24510")

# Create a new data frame that contains the sum of all the emission by year.
plot.data  <- ddply(NEI.onRoad, .(year, fips), function(x) sum(x$Emissions))
names(plot.data)[3]  <- "Emissions" # Set emission column name

# Add county names
plot.data$county <- ifelse(plot.data$fips == "06037", "Los Angeles", "Baltimore City")

# Set the output options
png(file = "plot6.png", width = 640, height = 480, bg = "transparent")

# Plot the data. 
g <- ggplot(plot.data, aes(factor(year), Emissions, fill=county))
g <- g + geom_bar(stat="identity", position="dodge") +
         facet_grid(. ~ county) +
         xlab("Year") +
         ggtitle("Motor Vehicle Emissions in Baltimore and Los Angeles: 1999-2008")

# Print to the device.
print(g)

# Close the file device.
dev.off()
