## Coursera - Exploratory Data Analysis - Assignment 2 - Plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Prepare data: Total emission from Baltimore City, Maryland (fips == "24510")
# for each year
NEI_baltimore <- subset(NEI, NEI$fips=="24510")
total <- tapply(NEI_baltimore$Emissions, NEI_baltimore$year, sum)

# Create plot
barplot(total/1e6, 
        main="Total PM2.5 emission in Baltimore City",
        xlab="Year",
        ylab="Emission (mega tons)")

# Save plot as PNG
dev.copy(png, file = "plot2.png",
         width = 480, 
         height = 480)
dev.off()