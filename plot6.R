##Exploratory Data Analysis Coursera Course - Course Projeect 2
##Allen Seol

##Compare emissions from motor vehicle sources in Baltimore City with emissions from 
##motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##Which city has seen greater changes over time in motor vehicle emissions?

#Loading Dplyr and ggplot2 library
library(dplyr)
library(ggplot2)

## Reading Summary data of PM25
NEI <- readRDS("summarySCC_PM25.rds")

##Reading Classification Code
SCC <- readRDS("Source_Classification_Code.rds")

##Turning Year and FIP into factors
NEI2 <- transform(NEI, year = factor(year))
NEI2 <- transform(NEI, fips = factor(fips))

##Subetting To City of Baltimore fips == "24510" and LA fips == "06037")
bmla <- filter(NEI2, fips == "24510" | fips == "06037")

##Index of SCC with Vehicles
##Making Assumption that in the EI.Sector, Grepping "Vehicles" will give you all motor vehicle sources
vec <- grep("Vehicles",SCC$EI.Sector)  ##Index
scc_vec <- SCC$SCC[vec]  ##Vector of SCC Values to Subset
length <- length(scc_vec)  ##length of the vector

##Empty Vector
bmla_vec <- NULL 

##Subsetting Combined Baltimore/LA Data Using Vector of SCC Values to Draw From
for(i in 1:length){
  bmla_vec <- rbind(bmla_vec,filter(bmla, SCC == scc_vec[i]))
}

png(file = "plot6.png", width = 480, height = 480)

##boxplot of LA and Baltamore data
bmla_graph <- qplot(y = log10(Emissions), x = as.factor(year), data = bmla_vec) + geom_boxplot(aes(fill = fips))+
ggtitle("Vehicle Source Emission of LA Versus Baltimore") + xlab("Year") + ylab ("Log10 PM25 Emissions") +
scale_fill_discrete(name="Cities",labels=c("Los Angeles", "Baltimore"))

print(bmla_graph)

dev.off()
