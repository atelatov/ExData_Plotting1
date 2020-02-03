# Load the data #######################
rm(list=ls())
# Set your working directory

# Load libraries
library(sqldf)  # needed to read in subset of rows from data
library(dplyr)  # needed to combine date and time

# Read in data -- subset of rows for dates 1/2/2007 and 2/2/2007
my_data <- read.csv.sql("household_power_consumption.txt", sep=";", header=TRUE, sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'")
# Look at it
head(my_data)

# Add now column
t <- strptime(paste(my_data$Date, my_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
now <- as.POSIXct(t)
my_data <- cbind(my_data, now)

# Create png file
png(filename="plot4.png")
# Make plot 4
par(mfrow = c(2,2))  # four plots, rows fill first
label_1 <- "Global Active Power (kilowatts)"
with(my_data, plot(as.POSIXct(now), Global_active_power, type="l",
                   xlab = "", ylab = label_1))
with(my_data, plot(as.POSIXct(now), Voltage, type="l",
                   xlab = "datetime", ylab = "Voltage"))
plot(my_data$now, my_data$Sub_metering_1, type="n",
     xlab = "", ylab = "Energy sub metering")
lines(my_data$now, my_data$Sub_metering_1, col="black")
lines(my_data$now, my_data$Sub_metering_2, col="red")
lines(my_data$now, my_data$Sub_metering_3, col="blue")
sub_legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",col=c("black","red","blue"), pch = 15,
       legend=sub_legend)
colnames(my_data)
with(my_data, plot(as.POSIXct(now), Global_reactive_power, type="l",
                   xlab = "datetime"))
# Close file
dev.off()
