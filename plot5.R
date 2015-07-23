##Exploratory Data Analysis Coursera Course - Course Projeect 2
##Allen Seol

## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

#Loading Dplyr Library
library(dplyr)
library(ggplot2)

## Reading Summary data of PM25
NEI <- readRDS("summarySCC_PM25.rds")
##Reading Classification Code
SCC <- readRDS("Source_Classification_Code.rds")

##Turning Year into factor
NEI2 <- transform(NEI, year = factor(year))

##Subetting To City of Baltimore fips == "24510"
bm <- filter(NEI2, fips == "24510")

##Index of SCC with Vehicles
##Making Assumption that in the EI.Sector, Grepping "Vehicles" will give you all motor vehicle sources
vec <- grep("Vehicles",SCC$EI.Sector)  ##Index
scc_vec <- SCC$SCC[vec]  ##Vector of SCC Values to Subset
length <- length(scc_vec)  ##length of the vector

##Empty Vector
bm_vec <- NULL 

##Subsetting Baltimore Data Using Vector of SCC Values to Draw From
for(i in 1:length){
  bm_vec <- rbind(bm_vec,filter(bm, SCC == scc_vec[i]))
}

png(file = "plot5.png", width = 480, height = 480)

bmp <- qplot(y = log10(Emissions), x = year, data = bm_vec) + 
  geom_boxplot(outlier.colour = "green", outlier.size = 2) +
  ggtitle("Emissions from Motor Vehicle Sources in Baltimore") + xlab("Year") + ylab ("Log10 PM25 Emissions")


print(bmp)

dev.off()
