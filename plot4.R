##Exploratory Data Analysis Coursera Course - Course Projeect 2
##Allen Seol

##Across the United States, how have emissions from coal combustion-related 
##sources changed from 1999-2008?

#Loading Dplyr Library
library(dplyr)
library(ggplot2)

## Reading Summary data of PM25
NEI <- readRDS("summarySCC_PM25.rds")
##Turning Year into factor
NEI2 <- transform(NEI, year = factor(year))

##Reading Classification Code
SCC <- readRDS("Source_Classification_Code.rds")

##Getting Index from SCC of all Coal Sources,
coal_index <- grep("Coal",SCC$EI.Sector)
coal_scc <- SCC$SCC[coal_index]
scc_length <- length(coal_scc)

##Creating An Empty Data.Frame to subset
NEI_Coal <- NULL

##Subset Summary Data into only Coal Index Sources from SCC Numbers
for(i in 1:scc_length){
  NEI_Coal <- rbind(NEI_Coal,filter(NEI2, SCC == coal_scc[i]))
}

png(file = "plot4.png", width = 480, height = 480)

##Boxplot of Coal Sources of log10Emissions by Year.
bmp <- qplot(y = log10(Emissions), x =year, data = NEI_Coal) +
  geom_boxplot(outlier.colour = "green", outlier.size = 2) +
  ggtitle("Emissions from Coal Sources") + xlab("Year") + ylab ("Log10 PM25 Emissions")

print(bmp)

dev.off()