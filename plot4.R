##plot4.R
## platform: Mac

plot4 <- function(){
    library(dplyr)
    
### Download and unzip file when it is not in the folder
    datasource <- "https://d396qusza40orc.cloudfront.net/
                   exdata%2Fdata%2Fhousehold_power_consumption.zip"
    filename <- "household_power_consumption.txt"
    if(!file.exists(filename)){
        download.file(url=datasource, destfile = "./zipdatafile.zip", 
                      method="curl")
        unzip("./zipdatafile.zip")
    }
    
### Read data and convert date/time to POSIXlt type
    fullread <- read.table("./household_power_consumption.txt",sep=";", 
                           header=TRUE, stringsAsFactors=FALSE, na.strings="?")
    fullread <- mutate(fullread, Date = as.Date(Date, format = "%d/%m/%Y"))
    usefuldate <- filter(fullread, Date=="2007-02-01" | Date == "2007-02-02")
    usefuldate <- mutate(usefuldate, datentime = paste(Date, Time))
    usefuldate$datentime <- strptime(usefuldate$datentime, 
                                     format = "%Y-%m-%d %H:%M:%S") 
    
### Plotting plot4.png
    png(filename = "plot4.png", width = 480, height = 480, units = "px", 
        bg = "transparent")
    par(mfrow=c(2,2))
    with(usefuldate, plot(x = datentime, y = Global_active_power, type = "l",
                          xlab = "", ylab = "Global Active Power"))
    with(usefuldate, plot(x = datentime, y = Voltage, type = "l", 
                           xlab = "datetime", ylab = "Voltage" ))
    with(usefuldate, plot(x = datentime, y = Sub_metering_1, type = "l", 
                           xlab = "", ylab = "Energy sub metering" ))
    with(usefuldate, lines(x = datentime, y = Sub_metering_2, col = "red" ))
    with(usefuldate, lines(x = datentime, y = Sub_metering_3, col = "blue" ))
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3") )
    with(usefuldate, plot(x = datentime, y = Global_reactive_power, 
                           type = "l", xlab = "datetime" ))
    dev.off()
    
}