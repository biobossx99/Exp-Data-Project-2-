##Exploratory Data Analysis Coursera Course - Course Projeect 2
##Allen Seol

##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##Which have seen increases in emissions from 1999-2008? 
##Use the ggplot2 plotting system to make a plot answer this question.

#Loading Dplyr Library
library(dplyr)
library(ggplot2)

## Reading Summary data of PM25
NEI <- readRDS("summarySCC_PM25.rds")

##Turning Year into factor
NEI2 <- transform(NEI, year = factor(year))

##Subetting To City of Baltimore fips == "24510"
##Turning Emission Type into factor
bm <- filter(NEI2, fips == "24510")
bm <- transform(bm, type = factor(type))

png(file = "plot3.png", width = 480, height = 480)

##Creating GGplot of boxplot 
bmp <- qplot(y = log10(Emissions), x = type, data = bm)  + geom_boxplot(aes(fill = factor(year))) +
  ggtitle("Baltimore Emissions by Year and Type") + xlab("Emission Type") + ylab ("Log10 Emissions")

print(bmp)

dev.off()