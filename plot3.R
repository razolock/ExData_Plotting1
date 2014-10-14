## read the data into a data frame "a" using read.table
a <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## subset the data into a data frame that only includes "1/2/2007", "2/2/2007"
b <- a[a$Date %in% c("1/2/2007", "2/2/2007"), ]

## create combined date and time column in POSIXlt format
b$tempDateTime <- NA
b$dateTime <- NA
b$tempDateTime <- paste(b$Date, b$Time)
b$dateTime <- strptime(b$tempDateTime, "%d/%m/%Y %H:%M:%S")

## prepare data (all numeric, convert "?" to NA)
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

## create plot 3
par(mfrow = c(1, 1))
with(b, plot(dateTime, m1, 
             type = "l",
             xlab = "",
             ylab = "Energy sub metering")
)
lines(b$dateTime, b$m2, col = "red")
lines(b$dateTime, b$m3, col = "blue")
legend("topright", lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

## create png file
dev.copy(png, file = "plot3.png")
dev.off()