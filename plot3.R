
#sqldf package allows the ability to read specific rows from a csv file using a sql syntax
#install.packages("sqldf")
library(sqldf)

plot3 <- function(){
        
        # Read the file, only contents for the two dates we are interested in
        edata <- read.csv.sql(file = "./data/household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")
        
        # add a new column that combines the date and time
        edata <- transform(edata, date_time = strptime(paste(edata$Date, edata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))
        
        # open png device
        png(filename = "plot3.png", width = 480, height = 480)
        
        # draw the plot with first meter reading
        plot(edata$date_time, edata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
        
        #Add the lines for other two readings
        lines(edata$date_time, edata$Sub_metering_2, type = "l", col = "red")
        lines(edata$date_time, edata$Sub_metering_3, type = "l", col = "blue")
        
        #Add  legend
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"), 
               lty = 1, lwd = 2,
               cex = 0.7)
        
        # close the device
        dev.off()
}
