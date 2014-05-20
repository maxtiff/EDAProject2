#### Assignment:
#### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#### Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Source data.table library and download.R functions
library(data.table)
library(plyr)
source("download.R")

## Set variables for download() function parameters.
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

total_emissions <- aggregate.data.frame(NEI$Emissions, "sum", by=list(NEI$year))
total_emissions$x <- total_emissions$x * .000001

# png(filename="plot1.png", width=480, height=480)
with(total_emissions, plot(Group.1, x, type ="b"))
# dev.off()
