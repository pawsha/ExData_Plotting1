
#sqldf package allows the ability to read specific rows from a csv file using a sql syntax
#install.packages("sqldf")
library(sqldf)
plot1 <- function(){
        
        # Read the file, only contents for the two dates we are interested in
        edata <- read.csv.sql(file = "./data/household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")
        
        # add a new column that combines the date and time
        edata <- transform(edata, date_time = strptime(paste(edata$Date, edata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))
        
        # open png device
        png(filename = "plot1.png", width = 480, height = 480)
        # draw the hist plot on the device
        hist(edata$Global_active_power, col = "red", xlab="Global Active Power (kilowwatts)", ylab = "Frequency", main = "Global Active Power")
        
        # close the device
        dev.off()
}
