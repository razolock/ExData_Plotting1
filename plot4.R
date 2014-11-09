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

## Plot 4
## Uses the power data table previously created
# Creates 4 plots, clockwise from top left
# Plot 1 - (previous plot2) Global Active Power consumption over the subset data time range
# Plot 2 - minute-averaged Voltage over the subset data time range
# Plot 3 - Energy sub metering measurements over the subset data time range
# Plot 4 - Global reactive power consumption over the subset data time range
plot4 <- function(power) {
  plot2 <- function(power) {
    plot(x = power$dateTime, 
         y = power$Global_active_power,
         type = 'l',
         xlab = '',
         ylab = 'Global Active Power (kilowatts)',
         mgp = c(3,1,0))
  }
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
  plotVoltage <- function(power) {
    plot(x = power$dateTime,
         y = power$Voltage,
         type = 'l',
         xlab = 'datetime',
         ylab = 'Voltage')
  }
  plotGlobalReactivePower <- function(power) {
    plot(x = power$dateTime,
         y = power$Global_reactive_power,
         type = 'h',
         xlab = 'datetime',
         ylab = 'Global_reactive_power')
  }
  par(mfrow = c(2,2))
  with(power, {
    plot2(power)
    plotVoltage(power)
    plot3(power, bty = 'n')
    plotGlobalReactivePower(power)
  })
}

## Creates and saves png file of plot 3
makePlot4 <- function(power, myFilename = 'plot4.png') {
  plot4(power)
  dev.copy(png, file = myFilename, width = 480, height = 480, units = "px")
  dev.off()
}