
#sqldf package allows the ability to read specific rows from a csv file using a sql syntax
#install.packages("sqldf")
library(sqldf)

plot2 <- function(){
        
        # Read the file, only contents for the two dates we are interested in
        edata <- read.csv.sql(file = "./data/household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")
        
        # add a new column that combines the date and time
        edata <- transform(edata, date_time = strptime(paste(edata$Date, edata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))
        
        # open png device
        png(filename = "plot2.png", width = 480, height = 480)
        
        # draw the line plot on the device
        plot(edata$date_time, edata$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
        
        # close the device
        dev.off()
}
