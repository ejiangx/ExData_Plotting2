# Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load packages
library(dplyr)
library(ggplot2)

# Question 4: Changes in emissions from 1999-2008 from coal combustion-related sources
# Subset coal combustion sources
combustion <- grepl("combustion", SCC$SCC.Level.One, ignore.case = TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
SCC.coalcomb <- SCC[(coal & combustion), ]
NEI.coalcomb <- NEI[NEI$SCC %in% SCC.coalcomb$SCC, ]

# Merge data sets
NEI_SCC <- merge(x = NEI.coalcomb, y = SCC.coalcomb, by = 'SCC')

# Determine sum by year
coalcomb_year <- NEI_SCC %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

# Plot
p <- ggplot(data = coalcomb_year, aes(year, totalEmissions))
png("plot4.png", width = 480, height = 480)
print(p + geom_point() + geom_line() + 
        labs(title = "Coal Combustion Source Emissions", y = "Total PM2.5 Emissions (Tons)"))
dev.off()