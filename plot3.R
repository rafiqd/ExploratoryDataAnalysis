library(plyr)
library(ggplot2)

question3 <- function(nei){
    
    nei <- subset(nei, nei$fips == "24510")
    year_dat <- ddply(nei, .(year, type), summarize, Emissions = sum(Emissions))
    p <- ggplot(year_dat, aes(year, Emissions)) + geom_point() + geom_line()
    p + facet_grid(. ~ type) + theme(axis.text.x = element_text(angle=90) )
    ggsave("plot3.png")
}

main <- function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    question3(NEI)
}