# Exploratory Data Analysis: Course Project 2

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Getting the data if is not present, just checking the 1st
dataset <- "summarySCC_PM25.rds"
zip.filename <- "NEI_data.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists(dataset)) {
  print("Dataset is not present")
  if (!file.exists(zip.filename)) {
    print("Zip file is not present, downloading...")
    download.file(url, zip.filename, method = "curl")
  }
  print("Unzipping file...")
  unzip(zip.filename)
}

library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# this is like `select sum(Emissions) from NEI group by year` in SQL
plot1.data <- NEI %>%
  group_by(year) %>%
  summarise(
    total_emissions = sum(Emissions, na.rm = TRUE)
  )

# Generating the plot and saving it
png(filename = "plot1.png", bg = "transparent")
plot(plot1.data, type = "l", ylab = "Total PM2.5 emission from all sources", xlab = "Years")
dev.off()
