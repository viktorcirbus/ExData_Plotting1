power <- read.csv("C:/Users/Administrator/My Cubby/Coursera/DataScience/Exploratory Data Analysis/P_01/R/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
powers=subset(power,Date=="1/2/2007"|Date=="2/2/2007")
powers$datetime =paste(powers$Date," ",powers$Time)
powers$datetime2=as.POSIXct(powers$datetime,format="%d/%m/%Y %H:%M:%S")
powers$Global_active_power=as.numeric(powers$Global_active_power)
powers$Global_reactive_power=as.numeric(powers$Global_reactive_power)
powers$Voltage=as.numeric(powers$Voltage)
powers$Global_intensity=as.numeric(powers$Global_intensity)
powers$Sub_metering_1=as.numeric(powers$Sub_metering_1)
powers$Sub_metering_2=as.numeric(powers$Sub_metering_2)
powers$Sub_metering_3=as.numeric(powers$Sub_metering_3)

power3a=subset(powers[,c("datetime2","Sub_metering_1")])
power3a$group=1
names(power3a)[2]<-"measure"

power3b=subset(powers[,c("datetime2","Sub_metering_2")])
power3b$group=2
names(power3b)[2]<-"measure"

power3c=subset(powers[,c("datetime2","Sub_metering_3")])
power3c$group=3
names(power3c)[2]<-"measure"

power3all=rbind(power3a,power3b,power3c)
power3all$measure=as.numeric(power3all$measure)

png(filename = "plot4.png",width=480, height=480)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 2), oma = c(0, 0, 0, 0))
with(powers,plot(Global_active_power~datetime2,type="l",xlab="",ylab="Global Active Power"))
with(powers,plot(Voltage~datetime2,type="l",xlab="datetime",ylab="Voltage"))
with(power3all,plot(datetime2,measure,ylab="Energy sub metering",xlab="",type="n"))
with(subset(power3all, group == 3), lines(datetime2,measure, col = "blue"))
with(subset(power3all, group == 2), lines(datetime2,measure, col = "red"))
with(subset(power3all, group == 1), lines(datetime2,measure, col = "black"))
legend("topright",bty="n",lwd=1 ,pch=c(NA,NA,NA) ,col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
with(powers,plot(Global_reactive_power~datetime2,type="l",xlab="datetime",ylab="Global_reactive_power"))


dev.off()

