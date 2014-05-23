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
# neiBLMV <- NEI[NEI$fips %in% c("24510","06037"),]
neiBalmer <- NEI[NEI$fips %in% c("24510"),]
neiLA <- NEI[NEI$fips %in% c("06037"),]

## Subset SCC by motor vehicle emissions classification.
sccMV <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector, ignore.case=TRUE),]

## Subset NEI data by motor vehicle emissions.
#neiMV<- subset(neiBLMV, SCC %in% sccMV$SCC)
neiBMV <- subset(neiBalmer, SCC %in% sccMV$SCC)
neiLAMV <- subset(neiLA, SCC %in% sccMV$SCC)

## Aggregate emissions data by year for Baltimore City, MD and Los Angeles, CA.
emissionsTotalBMV <- aggregate(Emissions~year,sum,data = neiBMV)
emissionsTotalLAMV <- aggregate(Emissions~year,sum,data = neiLAMV)

## Getting the percentage change in emissions for each city.
vBM <- c(emissionsTotalBMV$Emissions[1], emissionsTotalBMV$Emissions)
chgBMV = diff(vBM)/vBM[-length(vBM)] * 100
chgBMV = round(chgBMV, digits = 2)
emissionsTotalBMV$Emissions <- chgBMV

vLA <- c(emissionsTotalLAMV$Emissions[1], emissionsTotalLAMV$Emissions)
chgLAMV = diff(vLA)/vLA[-length(vBM)] * 100
chgLAMV = round(chgLAMV, digits = 2)
emissionsTotalLAMV$Emissions <- chgLAMV

## Plot time series graph of log of total motor vehicle emissions for the Baltimore City area.
g <- ggplot() + geom_line(data=emissionsTotalBMV, aes(year, Emissions, color='red')) + geom_line(data=emissionsTotalLAMV, aes(year, Emissions, color='blue'), ) + ggtitle("Percent Change in Total Emissions\nfrom PM-2.5\nfrom Motor Vehicles \nin Baltimore City vs. Los Angeles") + theme(plot.title = element_text(lineheight=.8, face="bold")) + xlab("Years") + ylab("A2.6: Change of PM-2.5 Emissions, Percent")
ggsave(filename="plot6.png", width=4.80, height=4.80, dpi=100)

# g <- ggplot(neiMV, aes(year, Emissions, group = fips, colour = fips)) 
# g + geom_line(aes( y = Emissions ) , stat="summary", fun.y="sum", size = 1 ) + geom_point( aes( y = Emissions ) , stat="summary", fun.y="sum", size=4, shape=21, fill="white") + ggtitle("Total Emissions of PM-2.5 per year\nfrom Motor Vehicles \nin Baltimore City vs. Los Angeles") + theme(plot.title = element_text(lineheight=.8, face="bold")) + xlab("Years") + ylab("A2.6: Sum of PM-2.5 Emissions. Kilotons/Year")
# ggsave(filename="plot6.png", width=4.80, height=4.80, dpi=100)