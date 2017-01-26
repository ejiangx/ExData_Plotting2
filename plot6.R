# Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load packages
library(dplyr)
library(ggplot2)

# Question 6: Changes in emissions from 1999-2008 from motor vehicle sources
# Subset motor vehicle sources
motorvehicle <- grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE)
SCC.mv <- SCC[motorvehicle, ]
NEI.mv <- NEI[NEI$SCC %in% SCC.mv$SCC, ]

# Merge data sets
NEI_SCC <- merge(x = NEI.mv, y = SCC.mv, by = 'SCC')

# Determine sum by year for Baltimore City
motorvehicle_yearBC <- NEI_SCC %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))
motorvehicle_yearBC$city <- "Baltimore City"

# Determine sum by year for Los Angeles County
motorvehicle_yearLA <- NEI_SCC %>%
  filter(fips == "06037") %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))
motorvehicle_yearLA$city <- "Los Angeles County"

MV_yearBCLA <- rbind(motorvehicle_yearBC, motorvehicle_yearLA)
#MV_yearBCLA$city <- ifelse(MV_yearBCLA$fips == "06037", "Los Angeles", "Baltimore")

# Plot
p <- ggplot(data = MV_yearBCLA, aes(year, totalEmissions, color = city, group = city))
png("plot6.png", width = 480, height = 480)
print(p + geom_point() + geom_line() + 
        labs(title = "Motor Vehicle Source Emissions", y = "Total PM2.5 Emissions (Tons)"))
dev.off()