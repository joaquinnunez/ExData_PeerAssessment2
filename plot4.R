# Exploratory Data Analysis: Course Project 2

# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999-2008?

library(dplyr)
library(ggplot2)

# Assuming that the code is already available
NEI <- readRDS("summarySCC_PM25.rds")
SCC.DATA <- readRDS("Source_Classification_Code.rds")

# this is like `select sum(Emissions) from NEI where SCC in levels group by year` in SQL
# Using SCC.Level.Three to filter for coal combustion-related emissions
levels <- SCC.DATA[grep("Coal", SCC.DATA$SCC.Level.Three), "SCC"]
data <- subset(NEI, SCC %in% levels) %>%
  group_by(year) %>%
  summarise(
    total_emissions = sum(Emissions, na.rm = TRUE)
  )

# Generating the plot and saving it
qplot(year, total_emissions, data = data, geom = "line", ylab = "Total PM2.5 emissions",
    xlab = "Year", main = "Anual Emissions from coal combustion-related")
ggsave("plot4.png")
dev.off()
