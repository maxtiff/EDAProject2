#### Assignment
#### Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

## Source data.table library and download.R functions
library(data.table)
library(ggplot2)
source("download.R")

## Set variables for download() function parameters.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

SCC_coal_comb <- SCC[grepl("Combustion", SCC$SCC.Level.One, ignore.case=TRUE) & grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) | grepl("Lignite", SCC$SCC.Level.Three, ignore.case=TRUE),]
NEI_coal_comb <- subset(NEI, SCC %in% SCC_coal_comb$SCC)

ggsave(filename="plot4.png", width=4.80, height=4.80, dpi=100)
g <- ggplot(NEI_coal_comb, aes(year, Emissions))
g + geom_line(aes( y = Emissions ) , stat="summary", fun.y="sum",colour = "red", size = 1 ) + geom_point( aes( y = Emissions ) , stat="summary", fun.y="sum", size=4, shape=21, fill="white")