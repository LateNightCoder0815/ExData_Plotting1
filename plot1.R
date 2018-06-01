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
png("plot1.png", width=480, height=480)
hist(as.numeric(data$Global_active_power), 
     main="Global Active Power" , 
     xlab = 'Global Active Power (kilowatts)',col = 'red')
dev.off()
