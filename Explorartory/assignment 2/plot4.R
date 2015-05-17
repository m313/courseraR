## Coursera - Exploratory Data Analysis - Assignment 2 - Plot 4
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999???2008?

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Selecting coal combustion-related (ccr) sources by matching EI.Sector = "coal",
# which returns the three sectors:
# "Fuel Comb - Electric Generation - Coal", 
# "Fuel Comb - Industrial Boilers, ICEs - Coal", and
# "Fuel Comb - Comm/Institutional - Coal"
ccr <- as.character(SCC$SCC[grep("Coal",as.character(SCC$EI.Sector))])
NEI_ccr <- subset(NEI, is.element(NEI$SCC,ccr))

#  Total emission from all sources for each year
total <- tapply(NEI_ccr$Emissions, NEI_ccr$year, sum)

# Create plot
barplot(total, 
        main="Total PM2.5 emission from coal combustion-related sources",
        xlab="Year",
        ylab="Emission (tons)")

# Save plot as PNG
dev.copy(png, file = "plot4.png",
         width = 680, 
         height = 480)
dev.off()