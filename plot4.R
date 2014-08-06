setwd("~/EDA")
hpc <- read.table("~/EDA/household_power_consumption.txt", sep=";",dec=".", na.strings="?",header=TRUE)
str(hpc)
hpc$Date=as.Date(hpc$Date,"%d/%m/%Y")

#subsetting data to the 2 required  days
data=hpc[hpc$Date==as.Date("2007/02/01"),]
data2=hpc[hpc$Date==as.Date("2007/02/02"),]
data=rbind(data,data2)

#remove useless dataframe
rm(hpc);rm(data2)

# reconvert Date & Time to char
data$Date=as.character(data$Date)
data$Time=as.character(data$Time)

# paste Date,Time in 1 variable (Date)
data$Date <- strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")

# Plot4
png(file = "plot4.png", width = 480, height = 480, bg = "white")
par(mfrow=c(2,2))
with(data,plot(Date,Global_active_power, type="l", ylab="Global Active Power", xlab=""))
with(data,plot(Date,Voltage, type="l", ylab="Voltage", xlab="datetime"))
with(data,plot(Date,Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="grey"))
with(data,lines(Date,Sub_metering_2, col="red"))
with(data,lines(Date,Sub_metering_3, col="blue"))
legend("topright",legend=names(data)[7:9], lty=1,col=c("grey", "red", "blue"))
with(data,plot(Date,Global_reactive_power, type="l", ylab="Global_reactive_Power", xlab="datetime"))
dev.off()
