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

# Plot2
png(file = "plot2.png", width = 480, height = 480, bg = "white")
with(data,plot(Date,Global_active_power, type="l", ylab="Global Active Power (Kilowatts)", xlab=""))
dev.off()


