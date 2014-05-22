#### Assignment
#### Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#### Which have seen increases in emissions from 1999-2008? 
#### Use the ggplot2 plotting system to make a plot in order to answer this question.

library(ggplot2)
library(data.table)
source("download.R")

## Set variables for download() function parameters.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download(url)

## Read in NEI data
NEI <- readRDS("data/summarySCC_PM25.rds")

## Subset data for Baltimore City only.
balmerEmissions <- NEI[NEI$fips %in% c("24510"),]

## Plot graph with ggplot. Types are seperated into individual facets.
g <- ggplot(balmerEmissions, aes(year, Emissions, color=type))
g + geom_line(aes( y = Emissions ) , stat="summary", fun.y="sum", size = 1 ) + facet_wrap( ~ type, nrow = 2) + geom_point( aes( y = Emissions ) , stat="summary", fun.y="sum", size=4, shape=21, fill="white") + scale_color_brewer() + theme(legend.position="none") + ggtitle("Total Emissions of PM-2.5 per year\nby type in Baltimore City, MD ") + theme(plot.title = element_text(lineheight=.8, face="bold"))
ggsave(filename="plot3.png", width=4.80, height=4.80, dpi = 100)