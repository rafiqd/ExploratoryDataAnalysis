library(plyr)
library(ggplot2)

question1 <- function(nei){
    year_dat <- ddply(nei, .(year), summarize, Emissions = sum(Emissions))
    png('plot1.png')
    plot(year_dat$year, 
         year_dat$Emissions,
         xlab = "Year",
         ylab = "Total Emissions",
         type = "b",
         main = "Yearly Total Emissions")
    dev.off()
}


main <- function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    question1(NEI)
}