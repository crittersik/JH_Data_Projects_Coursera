PM25Emissions <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge dataset
md <- merge(SCC,PM25Emissions,by.x="SCC", by.y="SCC")

library(dplyr)
library(ggplot2)

# PLOT 3
PM25Emissions_Baltimore <- PM25Emissions[PM25Emissions$fips == "24510",]
PM25Emissions_Baltimore_type_year <- group_by(PM25Emissions_Baltimore, type, year)
PM25Emissions_Baltimore_type_year_sum <- summarise(PM25Emissions_Baltimore_type_year, total_year = sum(Emissions))

plot.new()
png(filename="Plot3.png", width = 480, height = 280, units = "px")
plot3 <- qplot(year,total_year,data=PM25Emissions_Baltimore_type_year_sum, color=type, ylab = "Emissions", main = "Emissions in Baltimore")
print(plot3)
dev.off()