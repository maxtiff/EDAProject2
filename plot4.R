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



