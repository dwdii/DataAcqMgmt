# Sandbox.R
require(ggmap)
library(plyr)
library(maptools); 
library(sp); 
library(gridExtra)
chartFileOutputFolder <- "C:/Code/R/DataAcqMgmt/FinalProject/Charts/"

bibBirthData <- bibentry(bibtype="Misc",
                         author=as.person("HHS"),
                         publisher="United States Department of Health and Human Services (US DHHS), Centers for Disease Control and Prevention (CDC), National Center for Health Statistics (NCHS), Division of Vital Statistics",
                         title="Natality public-use data 2007-2012 on CDC WONDER Online Database",
                         year=2014,
                         month="April",
                         url="http://wonder.cdc.gov/natality-current.html")

bibMapsInRBlog <- bibentry(bibtype="Misc",
                           author=as.person("Kevin Johnson"),
                           title="Making Maps in R",
                           year=2014,
                           url="http://www.kevjohnson.org/making-maps-in-r/")

bibGgplotFootnote <- bibentry(bibtype="Misc",
                              title="Best way to add a footnote to a plot created with ggplot2",
                              author=as.person("Wendi(Alan) Wang"),
                              year=2013,
                              url="http://bigdata-analyst.com/best-way-to-add-a-footnote-to-a-plot-created-with-ggplot2.html")
print(bibBirthData, style="html")

#####
# FUNCTION: geoVisual 
#
#
geoVisual <- function(shapeData, data, title, filename)
{  
  # select out the id and births columns
  subCountyBirth <- subset(data, select=c('County.Code', 'Births'))
  subCountyBirth <- rename(subCountyBirth, c('County.Code'='id'))
  
  #print(summary(subCountyBirth))

  # integrate the birth data and create a percentage metric
  shapeData <- join(shapeData, subCountyBirth, by='id')  
  shapeData <- dplyr::mutate(shapeData, birthPercent = Births / sum(Births, na.rm=TRUE))
  
  #print(summary(shapeData))
  #print(head(subset(shapeData, is.na(Births)), 100))
  
 
  if(TRUE) {
  map <- get_map(location=c(-98.579404, 39.828127), zoom=4)
  
  gmap <- ggmap(map)
  gmap <- gmap + scale_fill_gradientn(colours=rainbow(100, start=0.5))

  gmap <- gmap + geom_polygon(aes(x = long, y = lat, group = group, fill=birthPercent), 
                            data = shapeData, #, 
                            colour = 'white', 
                            alpha = .4,
                            size = .2
                            )
  gmap <- gmap + ggtitle(title)

#   gmap <- gmap + geom_polygon(aes(x = long, y = lat, group = group), 
#                             data = shapeData, #, 
#                             colour = 'white', 
#                             fill = 'black',
#                             alpha = .4,
#                             size = .3
#                           )  


  gmapft <- arrangeGrob(gmap, sub = textGrob("Created by Daniel Dittenhafer; Source: U.S. Health & Human Services", 
                                           x = 0, hjust = -0.1, vjust=0.1, gp = gpar(fontface = "italic", fontsize = 10)))
  #gmapft <- gmap
  plot(gmap)
  ggplot2::ggsave(sprintf("%s%s.png", chartFileOutputFolder, filename), plot=gmapft)
  }
}

#####
# FUNCTION: loadShapeData 
#
#
loadShapeData <- function()
{
  shpFile <- "C:/Users/Dan/Downloads/Data/US-County-ShapeFile/cb_2013_us_county_20m/cb_2013_us_county_20m.shp"
  
  # read data into R 
  shapefile <- readShapeSpatial(shpFile, 
                                proj4string = CRS("+proj=longlat +datum=WGS84"), IDvar="GEOID")
  
  shapeData <- fortify(shapefile)

  return (shapeData)
}

#####
# FUNCTION: loadBirthData 
#
#
loadBirthData <- function()
{
  # Load the Natality data
  birthFile <- "C:/Code/R/DataAcqMgmt/FinalProject/Data/Natality, 2007-2012-StateCounty.txt"
  birthData <- read.table(birthFile, 
                          header=TRUE, 
                          sep="\t", 
                          fill=TRUE, 
                          stringsAsFactors=FALSE,
                          colClasses=c('character', # Notes
                                       'character', # Year
                                       'character', # Year.Code
                                       'character', # Month
                                       'character', # Month.Code
                                       'character', # State
                                       'character', # State.Code
                                       'character', # County
                                       'character', # County.Code
                                       'numeric'))  # Births
  
  #print(birthData[is.na(birthData$Births),])
  birthDataWoNa <- subset(birthData, !is.na(birthData$Births))  
  
  return (birthDataWoNa)
}

#####
# FUNCTION: loadCensusData 
#
#
loadCensusData <- function()
{
  # Load the Natality data
  dataFile <- "C:/Code/R/DataAcqMgmt/FinalProject/Data/CO-EST2013-Alldata.txt"
  data <- read.table(dataFile, 
                          header=TRUE, 
                          sep=",", 
                          fill=TRUE, 
                          stringsAsFactors=FALSE) 
  
  print(summary(data))
  #print(birthData[is.na(birthData$Births),])
  #dataWoNa <- subset(birthData, !is.na(birthData$Births))  
  
  return (data)
}

#####
# FUNCTION: loadUnemploymentData 
#
#
loadUnemploymentData <- function()
{
  # Load the Natality data
  dataFile <- "C:/Code/R/DataAcqMgmt/FinalProject/Data/USUnemploymentRates2007-2012.csv"
  data <- read.table(dataFile, 
                     header=TRUE, 
                     sep=",", 
                     fill=TRUE, 
                     stringsAsFactors=FALSE) 
  
  print(summary(data))

  return (data)
}

# changeit<-function(x) {
#   x$data <- data.frame(a=rep(1, 2))
#   x$data2 <- data.frame(a=rep(4, 3))
# }
# 
# 
# x <- list()
# x$data <- data.frame(b=rep(2,3))
# print(head(x))
# print(head(x$data))
# changeit(x)
# print(head(x))
# print(head(x$data))

if(TRUE) {
  
  birthDataWoNa <- loadBirthData()
  censusData <- loadCensusData()
  unempData <- loadUnemploymentData()
  shapes <- loadShapeData()
  
  years <- c(2007,2008,2009,2010,2011,2012)
  months <- c("January") #, "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
  for(year in years){
    for (month in months ) { # seq(1, 12, by=1)
    birthsYrMonth <- subset(birthDataWoNa, birthDataWoNa$Year == year & birthDataWoNa$Month == month)
    
    print(summary(birthsYrMonth))
    
    title <- sprintf("U.S. Births - %s, %d", month, year)
    filename <- sprintf("%d_%s_US_Births", year, month)
  
    print(title)
    print(filename)
    
    geoVisual(shapes, birthsYrMonth, title, filename)
    }
  }
}
