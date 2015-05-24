#-------------------------------------------------------------------------------
#
# Exploratory Data Analysis - Project 2
#
# Author: Timothy R. Warren
# GitHub: https://github.com/kreas/ExData_Project2
# File: plot4.R
#
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
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

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Table

# Get the combustion and coal values from SCC and extract the subset from NEI
ss        <- unique(grep("coal", SCC$EI.Sector, ignore.case=T, value=T))
ss        <- subset(SCC, EI.Sector %in% ss)
NEI       <- subset(NEI, SCC %in% ss$SCC )

rm(ss) # Clean up workspace

# Set the output options
png(file = "plot4.png", width = 640, height = 480, bg = "transparent")

# Plot the data. 
g <- ggplot(data=NEI, aes(factor(year), Emissions, fill = type))
g <- g + geom_bar(stat="identity", position="dodge") +
         ggtitle("U.S. Coal Combustion-Related Emissions: 1999-2008")

# Print to the device.
print(g)

# Close the file device.
dev.off()
