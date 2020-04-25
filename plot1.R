## Exploratory Data Analysis Course @Coursera
## Course Project 1
##
## Creates the plot 1: Global Active Power vs Frequency 
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
png(filename="plot1.png", width = 480, height = 480)
hist(
  powerc$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)
dev.off()

