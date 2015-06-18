PM25Emissions <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge dataset
md <- merge(SCC,PM25Emissions,by.x="SCC", by.y="SCC")

library(dplyr)

# PLOT 2
PM25Emissions_Baltimore <- PM25Emissions[PM25Emissions$fips == "24510",]
PM25Emissions_Baltimore_year <- group_by(PM25Emissions_Baltimore, year)
PM25Emissions_Baltimore_year_sum <- summarise(PM25Emissions_Baltimore_year, total_year = sum(Emissions))

png(filename="Plot2.png", width = 480, height = 480, units = "px")
plot.new()
plot(PM25Emissions_Baltimore_year_sum, type = "b", ylab = "Total Emissions", xlab = "Year", main="Total emissions from PM2.5 in Baltimore")
dev.off()