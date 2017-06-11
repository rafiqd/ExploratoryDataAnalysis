library(plyr)
library(ggplot2)

question2 <- function(nei){
    nei <- subset(nei, nei$fips == "24510")
    year_dat <- ddply(nei, .(year), summarize, Emissions = sum(Emissions))
    png('plot2.png')
    plot(year_dat$year, 
         year_dat$Emissions,
         xlab = "Year",
         ylab = "Total Emissions",
         type = "b",
         main = "Yearly Total Emissions For Balitmore City")
    dev.off()
    
}

main <- function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    question2(NEI)
}