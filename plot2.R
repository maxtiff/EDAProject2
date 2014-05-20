#### Assignment
#### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#### Use the base plotting system to make a plot answering this question.

## Source data.table library and download.R functions
library(data.table)
library(plyr)
source("download.R")

## Set variables for download() function parameters.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

total_emissions <- aggregate.data.frame(NEI$Emissions, NEI$fips == 24510, "sum", by=list(NEI$year))