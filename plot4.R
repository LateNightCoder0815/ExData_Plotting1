## Define file name for download of dataset
fileName <- 'household_power_consumption.zip'

## Defined extracted file name of zip file
extractedName <- 'household_power_consumption.txt'

## Download dataset if not exist
if (!file.exists(fileName)){
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                fileName)
}

## Unzip files if not done previously
if (!file.exists(extractedName)){
  unzip(fileName)
}

data <- read.table(extractedName, sep =";", header = TRUE, 
                   colClasses=c("character", "character", rep("numeric",7)),
                   na ='?')

## Subsetting the data as only two days are used
data <- data[which(data$Date == '1/2/2007' | data$Date == '2/2/2007'),] 

## convert time
data$Time <- paste(data$Date,data$Time)
data$Time <- strptime(data$Time, format = '%d/%m/%Y %H:%M:%S')
data$Date <- as.Date(data$Time)

## Create png plot
png("plot4.png", width=480, height=480)

## Create panel 2 x 2
par(mfrow = c(2, 2))

## First plot
plot(data$Time,data$Global_active_power,type = 'l',xlab='',ylab='Global Active Power')

## Second plot
plot(data$Time,data$Voltage,type = 'l',xlab = 'datetime',ylab = 'Voltage')

## Third plot
plot(data$Time,data$Sub_metering_1,type = 'l',xlab='',ylab='Energie sub meetering')
lines(data$Time,data$Sub_metering_2,col='red')
lines(data$Time,data$Sub_metering_3,col='blue')
legend("topright",legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty = 1, col=c("black", "red", "blue"))

## Fourth plot
plot(data$Time,data$Global_reactive_power,type = 'l',xlab = 'datetime',ylab = 'Global_reactive_power')

## Close device
dev.off()
