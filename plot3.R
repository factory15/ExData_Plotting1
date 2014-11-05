
dat <- read.table("household_power_consumption.txt",header = TRUE,sep = ';')

##combine both days- yes i didnt have to do it this way
p1<- subset(dat,as.Date(dat$Date,format="%d/%m/%Y") == as.Date("01/02/2007",format="%d/%m/%Y"))
p2<- subset(dat,as.Date(dat$Date,format="%d/%m/%Y") == as.Date("02/02/2007",format="%d/%m/%Y"))

p<-rbind(p1,p2)

p[p=="?"]<-NA

p<-p[complete.cases(p),]



p$day <- weekdays(as.Date(p$Date))
p$Sub_metering_1 <- as.numeric(as.character(p$Sub_metering_1),as.is=FALSE,dec=".",numerals = "no.loss")
p$Sub_metering_2 <- as.numeric(as.character(p$Sub_metering_2),as.is=FALSE,dec=".",numerals = "no.loss")
p$Sub_metering_3 <- as.numeric(as.character(p$Sub_metering_3),as.is=FALSE,dec=".",numerals = "no.loss")

p$TImeOverall <- as.POSIXct(paste(p$Date, p$Time), format="%d/%m/%Y %H:%M")

p$TotalEnergy<-p$Sub_metering_1+p$Sub_metering_2+p$Sub_metering_3


png("plot3.png",width = 480, height = 480)
with(p, plot(p$TImeOverall, p$TotalEnergy,type = "n",ylab="Energy sub metering",xlab=""))
with(subset(p,p$TotalEnergy==p$Sub_metering_2), lines(p$TImeOverall,p$Sub_metering_2,col = "red"))

with(subset(p,p$TotalEnergy==p$Sub_metering_3), lines(p$TImeOverall,p$Sub_metering_3,col = "blue"))

with(subset(p,p$TotalEnergy==p$Sub_metering_1), lines(p$TImeOverall,p$Sub_metering_1,col = "black"))
legend("topright", lwd = c(2.5,2.5), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.off()
