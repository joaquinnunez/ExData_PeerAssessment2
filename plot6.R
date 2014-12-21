# Exploratory Data Analysis: Course Project 2

# Compare emissions from motor vehicle sources in Baltimore City with emissions from
# motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

# Assuming that the code is already available
NEI <- readRDS("summarySCC_PM25.rds")
SCC.DATA <- readRDS("Source_Classification_Code.rds")

# Using EI.Sector to filter for motor vehicle sources related emissions
levels <- SCC.DATA[grep("[Mm]obile|[Vv]ehicles", SCC.DATA$EI.Sector), "SCC"]
data <- subset(NEI, SCC %in% levels) %>%
  filter(fips == "24510" | fips == "06037") %>%
  group_by(fips, year) %>%
  summarise(
    total_emissions = sum(Emissions, na.rm = TRUE)
  )

# to have the correct labels in the plot
data$fips <- factor(data$fips, labels = c("Los Angeles", "Baltimore"))

# Generating the plot and saving it
qplot(year, total_emissions, data = data, geom = c("line", "point"), ylab = "Total PM2.5 emissions",
    xlab = "Year", main = "Comparison of emissions of Baltimore City and LA", color = fips)
ggsave("plot6.png")
dev.off()
