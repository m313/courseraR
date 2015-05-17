## Coursera - Exploratory Data Analysis - Assignment 2 - Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999???2008 for Baltimore City? Which have seen increases in
# emissions from 1999???2008? Use the ggplot2 plotting system to make a plot
# answer this question.


# Load libraries
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Prepare data: 
# subset data from Baltimore
NEI_baltimore <- subset(NEI, NEI$fips=="24510")

# Sum emissions for each type and year in new frame
types <- unique(NEI_baltimore$type)
years <- unique(NEI_baltimore$year)
df <- data.frame(Emissions=numeric(), type=character(), year=character(), 
                 samples=numeric(), stringsAsFactors=FALSE)
c <- 1
for (t in types){
    for (y in years){
        good <- (NEI_baltimore$type==t) & (NEI_baltimore$year==y)
        df[c,1] <- sum(NEI_baltimore$Emissions[good])
        df[c,2] <- t
        df[c,3] <- y
        df[c,4] <- sum(good)
        c <- c+1
    }
}

# create plot with subplot for each type
qplot(year, Emissions, data=df, facets= .~ type ) + 
    labs(title="PM2.5 emissions in Baltimore City (tons)")

# Save plot as PNG
dev.copy(png, file = "plot3.png",
         width = 680, 
         height = 480)
dev.off()