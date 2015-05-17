# Coursera Exploratory Data Analysis - Assignment 1 - Plot 4
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


# Prepare plot arrangement
par(mfrow = c(2, 2))

## Plot 1
plot(data_good$Time, data_good$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

## Plot 2
plot(data_good$Time, data_good$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

## Plot 3
plot(data_good$Time, data_good$Sub_metering_1,
     type="n",
     xlab="",
     ylab="Energy sub metering")
lines(data_good$Time, data_good$Sub_metering_1,
      col="black")
lines(data_good$Time, data_good$Sub_metering_2,
      col="red")
lines(data_good$Time, data_good$Sub_metering_3,
      col="blue")
legend("topright", pch = NA, lwd=1, cex=0.5,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 4
plot(data_good$Time, data_good$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

# Save PNG
dev.copy(png, file = "plot4.png",
         width = 480, 
         height = 480)
dev.off()




