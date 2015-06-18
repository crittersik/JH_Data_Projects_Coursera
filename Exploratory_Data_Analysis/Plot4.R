PM25Emissions <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge dataset
md <- merge(SCC,PM25Emissions,by.x="SCC", by.y="SCC")

library(dplyr)
library(ggplot2)

# PLOT 4
coal  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
SCC_coal <- SCC[coal, ]
PM25Emissions_SCC_coal <- merge(PM25Emissions, SCC_coal, by="SCC")
PM25Emissions_SCC_coal_year <- group_by(PM25Emissions_SCC_coal, year)
PM25Emissions_SCC_coal_year_sum <- summarise(PM25Emissions_SCC_coal_year, total_year = sum(Emissions))

plot.new()
png(filename="Plot4.png", width = 480, height = 280, units = "px")
plot4 <- qplot(year,total_year,data=PM25Emissions_SCC_coal_year_sum , ylab = "Total Emissions", main = "Emissions from coal combustion-related sources")
print(plot4)
dev.off()