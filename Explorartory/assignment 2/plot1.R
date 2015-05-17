## Coursera - Exploratory Data Analysis - Assignment 2 - Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.


# Read data
NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Prepare data: Total emission from all sources for each year
total <- tapply(NEI$Emissions, NEI$year, sum)

# Create plot
barplot(total/1e6, 
        main="Total PM2.5 emission from all sources",
        xlab="Year",
        ylab="Emission (mega tons)")

# Save plot as PNG
dev.copy(png, file = "plot1.png",
         width = 480, 
         height = 480)
dev.off()