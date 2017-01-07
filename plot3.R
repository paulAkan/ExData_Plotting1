### read complete data
### note the options so we have good data input
data.complete <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

### put date in proper context
data.complete$Date <- as.Date(data.complete$Date, format="%d/%m/%Y")

### subset the required data
data.model <- subset(data.complete, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

### remove data.complete to save space
rm(data.complete)

### create a new column called datetime
datetime <- paste(as.Date(data.model$Date), data.model$Time)
data.model$Datetime <- as.POSIXct(datetime)

### plot 3
with(data.model, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime, col='Red')
        lines(Sub_metering_3~Datetime, col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2.5, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

### Save to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
