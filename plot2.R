## read the data into a data frame "a" using read.table
a <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## subset the data into a data frame that only includes "1/2/2007", "2/2/2007"
b <- a[a$Date %in% c("1/2/2007", "2/2/2007"), ]

## create combined date and time column in POSIXlt format
b$tempDateTime <- NA
b$dateTime <- NA
b$tempDateTime <- paste(b$Date, b$Time)
b$dateTime <- strptime(b$tempDateTime, "%d/%m/%Y %H:%M:%S")

## global active power conversion
## change all "?" data to NA
## change data type to numeric
library (car)
b$tempGAP <- NA
b$tempGAP2 <- NA
b$GAP <- NA
b$tempGAP <- recode(b$Global_active_power, "'?' = NA")
b$tempGAP2 <- as.character(b$tempGAP)
b$GAP <- as.numeric(b$tempGAP2)

## create plot 2
par(mfrow = c(1, 1))
with(b, plot(dateTime, GAP, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)"))

## create png file
dev.copy(png, file = "plot2.png")
dev.off()