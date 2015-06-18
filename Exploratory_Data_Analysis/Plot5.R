PM25Emissions <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge dataset
md <- merge(SCC,PM25Emissions,by.x="SCC", by.y="SCC")

library(dplyr)
library(ggplot2)

# PLOT 4
PM25Emissions_Baltimore <- PM25Emissions[PM25Emissions$fips == "24510",]
motor_v  <- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
SCC_motor_v <- SCC[motor_v, ]
PM25Emissions_Baltimore_SCC_vehicle <- merge(PM25Emissions_Baltimore, SCC_motor_v, by="SCC")
PM25Emissions_Baltimore_SCC_vehicle_year <- group_by(PM25Emissions_Baltimore_SCC_vehicle, year)
PM25Emissions_Baltimore_SCC_vehicle_year_sum <- summarise(PM25Emissions_Baltimore_SCC_vehicle_year, total_year = sum(Emissions))

plot.new()
png(filename="Plot5.png", width = 480, height = 280, units = "px")
plot4 <- qplot(year,total_year,data=PM25Emissions_Baltimore_SCC_vehicle_year_sum , ylab = "Total Emissions", main = "Emissions from motor vehicle sources in Baltimore")
print(plot4)
dev.off()