# Exploratory Data Analysis: Course Project 2

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Assuming that the code is already available

library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

# this is like `select sum(Emissions) from NEI where fips = "24510" group by year` in SQL
data <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(
    total_emissions = sum(Emissions, na.rm = TRUE)
  )

# Generating the plot and saving it
png(filename = "plot2.png", bg = "transparent")
plot(data, type = "l", ylab = "Total PM2.5 emission from all sources", xlab = "Years", main = "Annual Emissions / Baltimore City, Maryland")
dev.off()
