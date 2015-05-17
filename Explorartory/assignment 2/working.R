## Coursera - Exploratory Data Analysis - Assignment 2 - Plot 1

## Download and extract data
# mydir <- tempdir()
# mydir <- getwd()
# 
# url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
# file <- basename(url)
# download.file(url, file)
# 
# unzip(file, exdir = mydir )
# list.files(tmpdir)
# 
# download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",mydir)


# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


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