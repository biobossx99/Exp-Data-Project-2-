##Exploratory Data Analysis Coursera Course - Course Projeect 2
##Allen Seol

##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##Using the base plotting system, make a plot showing 
##the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Loading Dplyr Library
library(dplyr)

## Reading Summary data of PM25
NEI <- readRDS("summarySCC_PM25.rds")

##Turning Year into factor
NEI2 <- transform(NEI, year = factor(year))

##Subsetting 2008 and finding median
year2008 <- filter(NEI2, year == 2008)
m1 <- median(year2008$Emissions)



##Boxplot by year and Aggregate Emissions with line representing 2008 median
boxplot(log10(Emissions) ~ year,NEI2, xlab = "Year", ylab = "log10(pm25)", 
        pch =1,outline=FALSE)
abline(h = log10(m1), col ="red", lwd =1)
title(main="Aggregate Emissions of All Sources 1999-2008")

## Use GroupBy Function to Summarize the yearly total emissions
by_year <- group_by(NEI2,year)
total_year <- summarise(by_year, total = sum(Emissions))

plot(total_year,xlab ="Year", ylab = "Total pm25") 
title(main = "Total Emissions of All Sources 1999-2008")





