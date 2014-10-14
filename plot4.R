## subset the data into a data frame that only includes "1/2/2007", "2/2/2007"
b <- a[a$Date %in% c("1/2/2007", "2/2/2007"), ]

## create combined date and time column in POSIXlt format
b$tempDateTime <- NA
b$dateTime <- NA
b$tempDateTime <- paste(b$Date, b$Time)
b$dateTime <- strptime(b$tempDateTime, "%d/%m/%Y %H:%M:%S")

## prepare data (all numeric, convert "?" to NA)
library (car)
b$tempGAP <- NA
b$tempGAP2 <- NA
b$GAP <- NA
b$tempGAP <- recode(b$Global_active_power, "'?' = NA")
b$tempGAP2 <- as.character(b$tempGAP)
b$GAP <- as.numeric(b$tempGAP2)

b$tempm1 <- NA
b$tempM1 <- NA
b$tempm1 <- recode(b$Sub_metering_1, "'?' = NA")
b$tempm1a <- NA
b$tempm1a <- as.character(b$tempm1)
b$m1 <- NA
b$m1 <- as.numeric(b$tempm1a)

b$tempm2 <- NA
b$tempM2 <- NA
b$m2 <- NA
b$tempm2 <- recode(b$Sub_metering_2, "'?' = NA")
b$tempM2 <- as.character(b$tempm2)
b$m2 <- as.numeric(b$tempM2)

b$tempm3 <- NA
b$tempM3 <- NA
b$m3 <- NA
b$tempm3 <- recode(b$Sub_metering_3, "'?' = NA")
b$tempM3 <- as.character(b$tempm3)
b$m3 <- as.numeric(b$tempM3)

b$tempv <- NA
b$tempV <- NA
b$v <- NA
b$tempv <- recode(b$Voltage, "'?' = NA")
b$tempV <- as.character(b$tempv)
b$v <- as.numeric(b$tempV)

b$tempgrp <- NA
b$tempGRP <- NA
b$grp <- NA
b$tempgrp <- recode(b$Global_reactive_power, "'?' = NA")
b$tempGRP <- as.character(b$tempgrp)
b$grp <- as.numeric(b$tempGRP)

## create plot 4
par(mfrow = c(2, 2))
with(b, {
  plot(dateTime, GAP, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")
  plot(dateTime, v, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(dateTime, m1, 
       type = "l",
       xlab = "",
       ylab = "Energy sub metering")
  lines(b$dateTime, b$m2, col = "red")
  lines(b$dateTime, b$m3, col = "blue")
  legend("topright", lty = 1, 
         col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(dateTime, grp, type = "l", xlab = "datetime", ylab = "global_reactive_power")
})

## create png file
dev.copy(png, file = "plot4.png")
dev.off()