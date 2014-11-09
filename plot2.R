library(dplyr)

## Set working directory
setwd("~/Documents/R")

## Read the household power consumption data set into a data table
## The data set was previously downloded
data <- read.table("household_power_consumption.txt",
                   sep=";",
                   header=TRUE,
                   na.strings="?",
                   colClasses=c("character",
                                "character",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric"))

##Filter the data table for dates "2007-02-01" and "2007-02-02"
data$Date <- as.Date(data$Date, "%d/%m/%Y")
power <- subset(data, Date == as.Date('2007-02-01') | 
                  Date == as.Date('2007-02-02'))

## Convert the date and time data to POSIX format
d <- as.character(power$Date)
t <- as.character(power$Time)
power$dateTime <- as.POSIXct(strptime(paste(d,t), '%Y-%m-%d %H:%M:%S'))

## Plot 2
## Function creates a frequency histogram of the
## Global Active Power values (in kilowatts) 
## Uses the power data table previously created

plot2 <- function(power) {
  plot(x = power$dateTime, 
       y = power$Global_active_power,
       type = 'l',
       xlab = '',
       ylab = 'Global Active Power (kilowatts)',
       mgp = c(3,1,0))
}

## Creates and saves png file of plot 2
makePlot2 <- function(power, myFilename = 'plot2.png') {
  plot2(power)
  dev.copy(png, file = myFilename, width = 480, height = 480, units = "px")
  dev.off()
}