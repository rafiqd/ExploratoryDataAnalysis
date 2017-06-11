library(plyr)
library(ggplot2)

city_labeller <- function(variable, value){
    city_names <- list(
        "06037"="Los Angeles County",
        "24510"="Baltimore City"
    )
    return(city_names[value])
}

question6 <- function(nei, scc_dat){
    scc_codes <- get_motor_vehicle_scc_codes(scc_dat)
    nei <- subset(nei, (fips == "06037" | fips == "24510") & SCC %in% scc_codes)
    year_dat <- ddply(nei, .(year, fips), summarize, Emissions = sum(Emissions))
    p <- ggplot(year_dat, aes(year, Emissions)) + geom_point() + geom_line()
    p + facet_grid(. ~ fips, labeller = city_labeller)
    ggsave("plot6.png")
}

main <- function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    question6(NEI, SCC)
}