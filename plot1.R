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

# Make plot 1
title_1 <- "Global Active Power"
label_1 <- "Global Active Power (kilowatts)"

# Create png file
png(filename="plot1.png")
# Make histogram
hist(my_data$Global_active_power, col="red", 
     main=title_1, xlab=label_1)
# Close file
dev.off()
