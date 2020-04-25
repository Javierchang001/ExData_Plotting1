## Exploratory Data Analysis Course @Coursera
## Course Project 1
##
## Creates the plot 4: Four graphics in one 
##
## Author: Javier Chang
##

## STEP 1 LOADING THE DATA
## -----------------------

# download the zip file and unzip it
destzipfile <- "exdata_data_household_power_consumption.zip"
if (!file.exists(destzipfile)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile)
  unzip(destfile, overwrite = TRUE)
}

# read the file into a data frame
powerc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", dec=".", na.strings="?",
                     colClasses=c("character", "character", rep("numeric",7) )) 

# subset two specific dates
powerc <- subset(powerc, powerc$Date=="1/2/2007" | powerc$Date=="2/2/2007")

# Convert date and time into a new Datetime column
powerc$Datetime <- as.POSIXlt(paste(powerc$Date, powerc$Time), format="%d/%m/%Y %H:%M:%S")


## STEP 2 MAKING THE PLOT
## -----------------------
png(filename="plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

## Plot 1
with(
  powerc,
  plot(
    Datetime,
    Global_active_power,
    type = "l",
    ylab = "Global Active Power (kilowatts)"
  )
)

## Plot 2
with(powerc,
     plot(Datetime, Voltage, type = "l", ylab = "Voltage"))

## Plot 3
with(powerc,
     plot(Datetime, Sub_metering_1, type = "n", ylab = "Energy sub metering"))
with(powerc,
     lines(Datetime, Sub_metering_1, type = "l", col="black"))
with(powerc,
     lines(Datetime, Sub_metering_2, type = "l",col="red"))
with(powerc,
     lines(Datetime, Sub_metering_3, type = "l", col="blue"))
legend(
  "topright",
  legend = grep("Sub", colnames(powerc), value = TRUE),
  col = c("black", "red", "blue"),
  lty = 1,
  lwd = 2,
  bty = "n"
)

## Plot 4
with(
  powerc,
  plot(
    Datetime,
    Global_reactive_power,
    type = "l",
    ylab = "Global_reactive_power"
  )
)



dev.off()

