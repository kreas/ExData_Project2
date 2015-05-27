#-------------------------------------------------------------------------------
#
# Exploratory Data Analysis - Project 2
#
# Author: Timothy R. Warren
# GitHub: https://github.com/kreas/ExData_Project2
# File: plot4.R
#
# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?
#
# Directions -------------------------------------------------------------------
#
# * Download the file from README.md and extract it to the root directory of
#   this project.
# * Source this file with `source('plot4.R')`
# * Once this script completes you can find the output in the project's root
#   Directory with the name plot4.png
#
#-------------------------------------------------------------------------------

# Load ggPlot2
library(ggplot2)
library(plyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Table

# Subset the data to the Baltimore region.
SCC.onRoad    <- subset(SCC, Data.Category == 'Onroad')
NEI.onRoad    <- subset(NEI, SCC %in% SCC.onRoad$SCC & fips == 24510)

# Create a new data frame that contains the sum of all the emission by year.
plot.data         <- ddply(NEI.onRoad, .(year), function(x) sum(x$Emissions))
names(plot.data)  <- c("year", "Emissions") # Set column names

# Set the output options
png(file = "plot5.png", width = 640, height = 480, bg = "transparent")

# Plot the data. 
g <- ggplot(plot.data, aes(factor(year), Emissions, fill=Emissions))
g <- g + geom_bar(stat="identity", position="dodge") +
         xlab("Year") +
         ggtitle("Motor Vehicle Emissions in Baltimore: 1999-2008")

# Print to the device.
print(g)

# Close the file device.
dev.off()
