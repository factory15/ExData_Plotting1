
dat <- read.table("household_power_consumption.txt",header = TRUE,sep = ';')

## combine two days- yes i didnt need to do it this way
p1<- subset(dat,as.Date(dat$Date,format="%d/%m/%Y") == as.Date("01/02/2007",format="%d/%m/%Y"))
p2<- subset(dat,as.Date(dat$Date,format="%d/%m/%Y") == as.Date("02/02/2007",format="%d/%m/%Y"))

p<-rbind(p1,p2)

p[p=="?"]<-NA

p<-p[complete.cases(p),]

p$day <- weekdays(as.Date(p$Date))
p$Global_active_power <- as.numeric(as.character(p$Global_active_power),as.is=FALSE,dec=".",numerals = "no.loss")



p$TImeOverall <- as.POSIXct(paste(p$Date, p$Time), format="%d/%m/%Y %H:%M")


png("plot2.png",width = 480, height = 480)

plot(p$TImeOverall,p$Global_active_power,type = "l",ylab="Global Active Power(kilowatts)",xlab="")
dev.off()
