PM25Emissions <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge dataset
md <- merge(SCC,PM25Emissions,by.x="SCC", by.y="SCC")

library(dplyr)
#group by year and sum 
PM25Emissions_year <- group_by(PM25Emissions, year)
PM25Emissions_year_sum <- summarise(PM25Emissions_year, total_year = sum(Emissions))

# make PLOT 1
png(filename="Plot1.png", width = 480, height = 480, units = "px")
plot.new()
plot(PM25Emissions_year_sum, type = "b", ylab = "Total Emissions", xlab = "Year", main = "Total emissions from PM2.5 in the United States")
dev.off()