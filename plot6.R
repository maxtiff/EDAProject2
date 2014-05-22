#### Assignment
#### Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#### Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
library(data.table)
source("download.R")

## Set variables for download() function parameters.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

## Read in NEI data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Subset data for Baltimore City, MD and Los Angeles, CA.
neiBlLa<- NEI[NEI$fips %in% c("24510","06037"),]


## Subset SCC by motor vehicle emissions classification.
sccMV <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector, ignore.case=TRUE),]

## Subset NEI data by motor vehicle emissions.
neiMV <- subset(neiBlLa, SCC %in% sccMV$SCC)

## Plot time series graph of motor vehicle emissions for the Baltimore City area.
png(filename="plot6.png", width=480, height=480)
g <- ggplot(neiMV, aes(year, Emissions, group = fips, colour = fips)) 
g + geom_line(aes( y = Emissions ) , stat="summary", fun.y="sum", size = 1 ) + geom_point( aes( y = Emissions ) , stat="summary", fun.y="sum", size=4, shape=21, fill="white")
dev.off()