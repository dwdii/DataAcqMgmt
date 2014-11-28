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

  
  #print(summary(subCountyBirth))

  # integrate the birth data and create a percentage metric
  shapeData <- join(shapeData, data, by='id')  
  #shapeData <- dplyr::mutate(shapeData, birthPercent = Births / sum(Births, na.rm=TRUE))
  shapeData <- dplyr::mutate(shapeData, BirthsNormalized = BirthsPer1000Pop)
  
  #print(summary(shapeData))
  #print(head(subset(shapeData, is.na(Births)), 100))
  
 
  if(TRUE) {
  map <- get_map(location=c(-97.279404, 39.828127), zoom=4)
  
  gmap <- ggmap(map)
  gmap <- gmap + scale_fill_gradientn(colours=rainbow(50, start=0.5),
                                      limits=c(.5, 2),name="Births/1000",
                                      guide=guide_colourbar(barwidth=0.5))

  gmap <- gmap + geom_polygon(aes(x = long, y = lat, group = group, fill=BirthsNormalized), 
                            data = shapeData, #, 
                            colour = 'white', 
                            alpha = .5,
                            size = .1)
  gmap <- gmap + xlab("Births per 1000 people by County based on 2010 Census")
  gmap <- gmap + ylab("")
  gmap <- gmap + theme(axis.ticks = element_blank(), 
                       axis.text = element_blank(),
                       axis.title = element_text(size=8),
                       plot.title = element_text(size=10),
                       legend.title = element_text(size=6))
  gmap <- gmap + ggtitle(title)
  
  gmapft <- arrangeGrob(gmap, sub = textGrob("Created by Daniel Dittenhafer; Source: U.S. Health & Human Services", 
                                           x = 0, hjust = -0.1, vjust=0.1, gp = gpar(fontface = "italic", fontsize = 6)))
  #gmapft <- gmap
  plot(gmap)
  ggplot2::ggsave(sprintf("%s%s.png", chartFileOutputFolder, filename), 
                  plot=gmapft,
                  width=5, height=4)
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
                          quote="",
                          fill=TRUE, 
                          stringsAsFactors=FALSE,
                          colClasses=c('character')) 
  
  data <- mutate(data, County.Code=paste(STATE, COUNTY, sep=""))
  data <- mutate(data, CENSUS2010POPThousands=as.numeric(CENSUS2010POP) / 1000)
  data <- mutate(data, CENSUS2010POPHundreds=as.numeric(CENSUS2010POP) / 100)
  
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

########
# FUNCTION: fillinCounties
#
fillinCounties <- function(r, reident)
{
  #print(r$State)
  
  counties <- subset(reident, reident$STNAME == r$State)
  countyLen <- nrow(counties)
  if(r$State == "Kansas1") {
    print(r)
    print(counties)
    print(countyLen)
    print(r$Births / countyLen)
    print(paste(counties$CTYNAME, ", ", counties$STNAME, sep=""))
    print(counties$County.Code) 
  }

  dfCountiesYearMonth <- data.frame( 
        Notes=rep(NA, countyLen), 
        Year=rep(r$Year, countyLen),
        Year.Code=rep(r$Year.Code, countyLen),
        Month=rep(r$Month, countyLen),
        Month.Code=rep(r$Month.Code, countyLen),
        State=rep(r$State, countyLen),
        State.Code=rep(r$State.Code, countyLen),
        County=paste(counties$CTYNAME, ", ", counties$STNAME, sep=""),
        County.Code=counties$County.Code,
        Births=r$Births * (as.numeric(counties$CENSUS2010POP) / sum(as.numeric(counties$CENSUS2010POP)))
        #,STNAME=rep(r$State, countyLen)
        #,CTYNAME=counties$CTYNAME
        )
  
  return (dfCountiesYearMonth)
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
  #unempData <- loadUnemploymentData()
  shapes <- loadShapeData()
  
  # Pull out just what we need of the census data
  censusCtyPop2010 <- subset(censusData, 
                             censusData$COUNTY != "000", 
                             select=c("County.Code", 
                                      "STNAME", 
                                      "CTYNAME", 
                                      "CENSUS2010POP", 
                                      "CENSUS2010POPHundreds", 
                                      "CENSUS2010POPThousands"))  
   
  # What are the unidentified counties? 
  unidentCounties <- subset(birthDataWoNa, stringr::str_detect(birthDataWoNa$County, "^Unidentified Counties,"))
  print(head(unidentCounties))
  
  reidentCounties <- subset(censusCtyPop2010, 
                            !(County.Code %in% birthDataWoNa$County.Code) ) 
                             # !stringr::str_detect(birthDataWoNa$County, "^Unidentified Counties,") )
  #print(head(reidentCounties, 100))
  
  # Attempt to divy up the Unidentified Counties across the rest of the state.
  unidentCountyAvg <- ddply(unidentCounties, .variables=c("County.Code", "Year.Code", "Month.Code"), .fun=fillinCounties, reidentCounties)
  birthDataWoNa <- rbind(birthDataWoNa, unidentCountyAvg)
  
  # Normalize to births per 1000 population
  print(head(censusCtyPop2010))
  birthDataWoNa <- join(birthDataWoNa, censusCtyPop2010, by="County.Code")
  birthDataWoNa <- mutate(birthDataWoNa, BirthsPer100Pop=Births / CENSUS2010POPHundreds)  
  birthDataWoNa <- mutate(birthDataWoNa, BirthsPer1000Pop=Births / CENSUS2010POPThousands)  
  
  # select out the id and births columns
  subCountyBirth <- subset(birthDataWoNa, select=c('Year', 'Month', 'County.Code', 'BirthsPer100Pop', 'BirthsPer1000Pop'))
  subCountyBirth <- rename(subCountyBirth, c('County.Code'='id'))  
  
  years <- c(2007, 2008, 2009, 2010, 2011, 2012)
  months <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
  for(year in years){
    for (m in seq(1, 12, by=1) ) { # 
    month = months[m]
    birthsYrMonth <- subset(subCountyBirth, subCountyBirth$Year == year & subCountyBirth$Month == month)
    
    print(summary(birthsYrMonth, 100))
    
    title <- sprintf("Continental U.S. Births - %s, %d", month, year)
    filename <- sprintf("%d_%00d_US_Births", year, m)
  
    print(title)
    print(filename)
    
    geoVisual(shapes, birthsYrMonth, title, filename)
    }
  }
}
