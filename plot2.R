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

balmerEmissions <- NEI[NEI$fips %in% c("24510"),]

emissionsTotal <- aggregate(Emissions~year,sum,data = balmerEmissions)
emissionsTotal$Emissions <- emissionsTotal$Emissions * .001


png(filename="plot2.png", width=480, height=480)
with(emissionsTotal, plot(year, Emissions, type = "b", col = "red", xlab="Years", ylab="A2.2: Sum of PM-2.5 Emissions. Kilotons/Year",axes=FALSE))
with(emissionsTotal, axis(1, at=(year)))
with(emissionsTotal, axis(2, at=(signif(Emissions, 2))))
dev.off()