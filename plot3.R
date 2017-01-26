# Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load packages
library(dplyr)
library(ggplot2)

# Question 3: Increase/Decrease in emissions from 1999-2008 in Baltimore City by Source
# Baltimore City, fips = 24510
BC_pm2year <- NEI %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarize(totalEmissions = sum(Emissions))

# Plot
p <- ggplot(data = BC_pm2year, aes(year, totalEmissions, color = type, group = type))
png("plot3.png", width = 480, height = 480)
print(p + geom_point() + geom_line())
dev.off()