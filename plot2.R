# Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load packages
library(dplyr)

# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
# Baltimore City, fips = 24510
BC_pm2year <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

# Plot
png("plot2.png", width = 480, height = 480)
with(BC_pm2year, plot(year, totalEmissions, 
                    type = "b",
                    main = "Baltimore City, Maryland",
                    xlab = "Year", 
                    ylab = "Total PM2.5 Emission"))

dev.off()