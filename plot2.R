#### Assignment
#### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#### Use the base plotting system to make a plot answering this question.

## Source data.table library and download.R functions
library(data.table)
source("download.R")

## Set variables for download() function parameters.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

NEI <- readRDS("data/summarySCC_PM25.rds")

NEI <- NEI[NEI$fips %in% c("24510"),]

total_emissions <- aggregate(Emissions~year,sum,data = NEI)

png(filename="plot2.png", width=480, height=480)
with(total_emissions, plot(year, Emissions, type = "b", col = "red")) 
dev.off()