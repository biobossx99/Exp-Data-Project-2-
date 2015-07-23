##Exploratory Data Analysis Coursera Course - Course Projeect 2
##Allen Seol

##Question:
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

#Loading Dplyr Library
library(dplyr)

## Reading Summary data of PM25
NEI <- readRDS("summarySCC_PM25.rds")

##Turning Year into factor
NEI2 <- transform(NEI, year = factor(year))

##Subetting To City of Baltimore fips == "24510"
bm <- filter(NEI2, fips == "24510")

##subsetting to Baltimore's 2008 year and finding the median
bm2008 <- filter(bm, year == 2008)
mbm <- median(bm2008$Emissions)

##Boxplot by year Total Emissions of Baltimore with line representing 2008 median
boxplot(log10(Emissions) ~ year, bm, xlab ="Year", ylab = "log10(pm25)",pch = 1)
title(main="Aggregate Emissions of Baltimore from 1999-2008",outline=FALSE)
abline(h = log10(mbm), col ="red", lwd =1)

## Use GroupBy Function to Summarize the yearly total emissions
by_year <- group_by(bm,year)
total_year <- summarise(by_year, total = sum(Emissions))

plot(total_year,xlab ="Year", ylab = "Total pm25") 
title(main = "Total Emissions of Baltimore 1999-2008")
