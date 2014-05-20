#### Assignment:
#### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#### Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Source data.table library and download.R functions
library(data.table)
source("download.R")

## Set variables for download() function parameters.
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")


total_emissions <- aggregate(Emissions~year,sum,data = NEI)

png(filename="plot1.png", width=480, height=480)
with(total_emissions, plot(year, Emissions, type = "b", col = "red")) 
dev.off()
