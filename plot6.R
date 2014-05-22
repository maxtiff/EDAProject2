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

neiMV$Emissions <- neiMV$Emissions * .001

## Plot time series graph of motor vehicle emissions for the Baltimore City area.
g <- ggplot(neiMV, aes(year, Emissions, group = fips, colour = fips)) 
g + geom_line(aes( y = Emissions ) , stat="summary", fun.y="sum", size = 1 ) + geom_point( aes( y = Emissions ) , stat="summary", fun.y="sum", size=4, shape=21, fill="white") + ggtitle("Total Emissions of PM-2.5 per year\nfrom Motor Vehicles \nin Baltimore City vs. Los Angeles") + theme(plot.title = element_text(lineheight=.8, face="bold")) + xlab("Years") + ylab("A2.6: Sum of PM-2.5 Emissions. Kilotons/Year")
ggsave(filename="plot6.png", width=4.80, height=4.80, dpi=100)