# setting working directory
setwd("~/EDA")

# reading file from url
url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("hpc.zip")){
  download.file(url,"hpc.zip", method="curl") #in some windows systems does not work
}

# unzip file into working directory
unzip("hpc.zip")

# read file into R environment
# get filename
zipsum=unzip("hpc.zip", list=T)
# read whole file txt (enough memory)
hpc <- read.table(zipsum$Name, sep=";",dec=".", na.strings="?",header=TRUE)

#subsetting data to the 2 required  days
hpc$Date=as.Date(hpc$Date,"%d/%m/%Y")
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

# create Plot1
png(file = "plot1.png", width = 480, height = 480, bg = "white")
with(data,hist(Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", col="red"))
dev.off()

