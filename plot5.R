library(plyr)
library(ggplot2)


get_motor_vehicle_scc_codes <- function(scc){
    scc <- subset(scc,
                  regexpr("Mobile - On-Road", scc$EI.Sector) != -1)
    return(scc$SCC)
}

question5 <- function(nei, scc_dat){
    scc_codes <- get_motor_vehicle_scc_codes(scc_dat)
    nei <- subset(nei, fips == "24510" & SCC %in% scc_codes)
    year_dat <- ddply(nei, .(year), summarize, Emissions = sum(Emissions))
    png("plot5.png")
    plot(year_dat$year, 
         year_dat$Emissions,
         xlab = "Year",
         ylab = "Total Emissions",
         type = "b",
         main = "Yearly Total Emissions of Motor Vehicles in Balitmore")
    dev.off()
}

main <- function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    question5(NEI, SCC)
}