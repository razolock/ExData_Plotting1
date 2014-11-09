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

## Plot 3
## Uses the power data table previously created
plot3 <- function(power, bty = 'o') {
  with(data, {
    plot(x = power$dateTime, 
         y = power$Sub_metering_1, 
         type = 'l', 
         col = 'black', 
         xlab = '',
         ylab = 'Energy sub metering')
    lines(x = power$dateTime, y = power$Sub_metering_2, col = 'red')
    lines(x = power$dateTime, y = power$Sub_metering_3, col = 'blue')
    legend('topright', 
           col = c('black', 'red', 'blue'), 
           legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
           lty = c(1,1,1),
           bty = bty)
  })
}

## Creates and saves png file of plot 3
makePlot3 <- function(power, myFilename = 'plot3.png') {
  plot3(power)
  dev.copy(png, file = myFilename, width = 480, height = 480, units = "px")
  dev.off()
}