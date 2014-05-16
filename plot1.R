library(data.table)
source("download.R")

  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  dataFileName <- "national_emissions"
  zipFileName <- "national_emissions.zip"

data <- download(url, dataFileName, zipFileName)