#### Assignment
#### How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(ggplot2)
library(data.table)
source("download.R")

## Set variables for download() function parameters.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

## Read in NEI data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Subset data for Baltimore City only.
NEI <- NEI[NEI$fips %in% c("24510"),]

## Subset SCC by motor vehicle emissions classification.
sccMV <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector, ignore.case=TRUE),]

## Subset NEI data by motor vehicle emissions.
neiMV <- subset(NEI, SCC %in% sccMV$SCC)

## Plot time series graph of motor vehicle emissions for the Baltimore City area.
ggsave(filename="plot5.png", width=4.80, height=4.80, dpi=100)
g <- ggplot(neiMV, aes(year, Emissions))
g + geom_line(aes( y = Emissions ) , stat="summary", fun.y="sum",colour = "red", size = 1 ) + geom_point( aes( y = Emissions ) , stat="summary", fun.y="sum", size=4, shape=21, fill="white")