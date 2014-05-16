####  download() function downloads file from specified url and unzips the downloaded file into a destination directory.
####  Returns a location of the data file to be processed by the createTable() function.
####  Function will not run if a directory of data previously exists.

download <- function(url, dataFileName, zipFileName) {
  
  #   url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  #   dataFileName <- "national_emissions.txt"
  #   zipFileName <- "national_emissions.zip"
  
  ## Establish destinations for zip and data files.
  dataDirPath <- "data"
  datasetDirPath <- file.path(dataDirPath, dataFileName)
  zipPath <- file.path(dataDirPath, zipFileName)
  
  ## Downloading/Unzipping data *iff* data doesn't already exist
  if(!file.exists(dataDirPath)){ 
    dir.create(dataDirPath) 
  }
  
  ## Validate if compressed file already exists.
  if(!file.exists(zipPath)){ 
    download.file(url, zipPath, mode="wb")
  }
  
  ## Validate if decompressed file exists in dir.
  if(!file.exists(datasetDirPath)) { 
    unzip(zipPath, exdir=dataDirPath)
  }
  
  return(datasetDirPath)
  
}