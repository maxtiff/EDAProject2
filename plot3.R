#### Assignment
#### Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#### Which have seen increases in emissions from 1999-2008? 
#### Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)
library(data.table)
library(reshape2)
source("download.R")

## Set variables for download() function parameters.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

## Read in NEI data
NEI <- readRDS("data/summarySCC_PM25.rds")

## Subset data for Baltimore City only.
NEI <- NEI[NEI$fips %in% c("24510"),]

## Plot graph with ggplot. Types are seperated into individual facets.
g <- ggplot(NEI, aes(year, Emissions))
g + geom_line(aes( y = Emissions ) , stat="summary", fun.y="sum" ) + facet_grid(. ~ type)
  



