# Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load packages
library(dplyr)

# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
by_year <- group_by(NEI, year)
pm2_year <- summarize(by_year, totalEmissions = sum(Emissions))

# Plot
png("plot1.png", width = 480, height = 480)
with(pm2_year, plot(year, totalEmissions, 
                    type = "b", 
                    xlab = "Year", 
                    ylab = "Total PM2.5 Emission"))

dev.off()