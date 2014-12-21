# Exploratory Data Analysis: Course Project 2

# Compare emissions from motor vehicle sources in Baltimore City with emissions from
# motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

# Assuming that the code is already available
NEI <- readRDS("summarySCC_PM25.rds")
SCC.DATA <- readRDS("Source_Classification_Code.rds")

# this is like `select sum(Emissions) from NEI where SCC in levels group by year` in SQL
# Using EI.Sector to filter for motor vehicle sources related emissions
levels <- SCC.DATA[grep("[Mm]obile|[Vv]ehicles", SCC.DATA$EI.Sector), "SCC"]
data <- subset(NEI, SCC %in% levels) %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(
    total_emissions = sum(Emissions, na.rm = TRUE)
  )

# Generating the plot and saving it
qplot(year, total_emissions, data = data, geom = "line", ylab = "Total PM2.5 emissions",
    xlab = "Year", main = "Anual Emissions from motor vehicle sources in Baltimore City")
ggsave("plot5.png")
dev.off()
