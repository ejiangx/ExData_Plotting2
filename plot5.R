# Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load packages
library(dplyr)
library(ggplot2)

# Question 5: Changes in emissions from 1999-2008 from motor vehicle sources in Baltimore City
# Subset motor vehicle sources
motorvehicle <- grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE)
SCC.mv <- SCC[motorvehicle, ]
NEI.mv <- NEI[NEI$SCC %in% SCC.mv$SCC, ]

# Merge data sets
NEI_SCC <- merge(x = NEI.mv, y = SCC.mv, by = 'SCC')

# Determine sum by year
motorvehicle_yearBC <- NEI_SCC %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

# Plot
p <- ggplot(data = motorvehicle_yearBC, aes(year, totalEmissions))
png("plot5.png", width = 480, height = 480)
print(p + geom_point() + geom_line() + 
        labs(title = "Motor Vehicle Source Emissions in Baltimore City", y = "Total PM2.5 Emissions (Tons)"))
dev.off()