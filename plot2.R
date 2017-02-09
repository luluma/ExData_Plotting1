##plot2.R
## platform: Mac

plot2 <- function(){
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
  
### Plotting plot2.png
    png(filename = "plot2.png", width = 480, height = 480, units = "px", 
        bg = "transparent")
    par(mfrow=c(1,1))
    plot(usefuldate$datentime, usefuldate$Global_active_power, type = "l", 
         xlab = "", ylab = "Global Active Power (kilowatts)")
    dev.off()
}



