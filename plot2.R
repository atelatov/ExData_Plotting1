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

# Set y label
y_label <- "Global Active Power (kilowatts)"
# Do stuff
t <- strptime(paste(my_data$Date, my_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
now <- as.POSIXct(t)
# Add new column
my_data <- cbind(my_data, now)
# Create png file
png(filename="plot2.png")
# Plote figure
with(my_data, plot(as.POSIXct(now), Global_active_power, type="l",
                   xlab = "", ylab = y_label))
# Close file
dev.off()
