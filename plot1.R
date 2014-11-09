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
                             
## Plot 1
## Function creates a frequency histogram of the
## Global Active Power values (in kilowatts) 
## Uses the power data table previously created
                             
plot1 <- function(power) {
  hist(power$Global_active_power, 
       freq = TRUE,
       col = 'red',
       xlab = "Global Active Power (kilowatts)",
       main = "Global Active Power",
       ylim = c(0,1200))
}
                             
## Creates and saves png file of plot 1
makePlot1 <- function(power, myFilename = 'plot1.png') {
  plot1(power)
  dev.copy(png, file = myFilename, width = 480, height = 480, units = "px")
  dev.off()
}