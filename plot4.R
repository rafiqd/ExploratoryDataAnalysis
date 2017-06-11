library(plyr)
library(ggplot2)


get_scc_coal_codes <- function(scc){
    scc <- subset(scc, 
                  regexpr("Combustion", scc$SCC.Level.One) != -1 & 
                      regexpr("Coal", scc$SCC.Level.Four) != -1)
    return(scc$SCC)
}

question4 <- function(nei, scc_dat){
    scc_codes <- get_scc_coal_codes(scc_dat)
    nei <- subset(nei, SCC %in% scc_codes)
    year_dat <- ddply(nei, .(year), summarize, Emissions = sum(Emissions))
    png("plot4.png")
    plot(year_dat$year, 
         year_dat$Emissions,
         xlab = "Year",
         ylab = "Total Emissions",
         type = "b",
         main = "Yearly Total Emissions of Coal Accross the United States")
    dev.off()
}

main <- function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    question4(NEI, SCC)
}