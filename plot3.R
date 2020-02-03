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

# Add column
t <- strptime(paste(my_data$Date, my_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
now <- as.POSIXct(t)
my_data <- cbind(my_data, now)

# Create png file
png(filename="plot3.png")
# Make plot 3
plot(my_data$now, my_data$Sub_metering_1, type="n",
     xlab = "", ylab = "Energy sub metering")
lines(my_data$now, my_data$Sub_metering_1, col="black")
lines(my_data$now, my_data$Sub_metering_2, col="red")
lines(my_data$now, my_data$Sub_metering_3, col="blue")
sub_legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",col=c("black","red","blue"), pch = 15,
       legend=sub_legend)
# Close file
dev.off()

