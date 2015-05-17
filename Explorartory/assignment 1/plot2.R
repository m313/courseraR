# Coursera Exploratory Data Analysis - Assignment 1 - Plot 2
#
# Estimating required memory for reading data
# 2075259 rows * 9 columns * 8 bytes/numeric / (2^20)
# =~ 142 MB


# Read data file
data <- read.table("../household_power_consumption.txt", 
                   na.strings="?", sep=";", header=TRUE, nrows=-1)

# Combine date and time info into data$Time
data$Time <- strptime(paste(data$Date, data$Time),format="%d/%m/%Y %H:%M:%S")

# Select the two days of interest
good_days <- (data$Time >= "2007-02-01") & (data$Time < "2007-02-03")
data_good <- data[good_days,]


## Plot 2
plot(data_good$Time, data_good$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png",
         width = 480, 
         height = 480)
dev.off()
