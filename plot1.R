## plot1.R
## platform: Mac

plot1 <- function(){
#### Download and unzip file when it is not in the folder
    datasource <- "https://d396qusza40orc.cloudfront.net/
                   exdata%2Fdata%2Fhousehold_power_consumption.zip"
    filename <- "household_power_consumption.txt"
    if(!file.exists(filename)){
        download.file(url=datasource, destfile = "./zipdatafile.zip", 
                      method="curl")
        unzip("./zipdatafile.zip")
    }
    
### Read data    
    fullread <- read.table("./household_power_consumption.txt",sep=";", 
                           header=TRUE, stringsAsFactors=FALSE, na.strings="?")
    fullread$Date <- as.Date(fullread$Date, format = "%d/%m/%Y")
    twodaydf <- fullread[(fullread$Date == "2007-02-01"|
                        fullread$Date == "2007-02-02"), ]
### Plotting plot1.png
    png(filename = "plot1.png", width = 480, height = 480, units = "px", 
        bg = "transparent")
    par(mfrow=c(1,1))
    hist(twodaydf$Global_active_power,main = "Global Active Power", 
         xlab="Global Active Power (kilowatts)", ylab="Frequency",
         col = "red")
    dev.off()
}
