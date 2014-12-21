# Exploratory Data Analysis: Course Project 2

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
# Which have seen increases in emissions from 1999?2008? Use the ggplot2 plotting system to make
# a plot answer this question.

library(dplyr)
library(ggplot2)

# Assuming that the code is already available
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

# this is like `select sum(Emissions) from NEI where fips = "24510" group by type, year` in SQL
data <- NEI %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarise(
    total_emissions = sum(Emissions, na.rm = TRUE)
  )

# Generating the plot and saving it
qplot(year, total_emissions, data = data, color = type, geom = "line", ylab = "Total PM2.5 emissions", 
    xlab = "Year", main = "Anual Emissions Baltimore City, Maryland by type of pollutant")
ggsave("plot3.png")
