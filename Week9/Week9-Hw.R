# 
# Author: Daniel Dittenhafer
#
# Created: Oct 23, 2014
#
# Description: Answers to Week 9 Assignment Part 2
#
require (rmongodb)

# Our MongoDB Connection Settings
mongohost <- "localhost:27017"
user <- ""
pass <- ""
db <- "unitedstates"
authdb <- db
ns = sprintf("%s.%s", db, "localities")

# Connect to Mongo.
mongo <- mongo.create(host=mongohost, username=user, password=pass, db=authdb)
print (mongo)

# If we got an error connecting, report it...
if(!mongo.is.connected(mongo)) {
  print(mongo.get.last.err(mongo))
} else {
  # Disable warning that will be generated by the
  # mongo.cursor.to.data.frame function calls.
  options(warn=-1)  
  
  # Get the Territories data frame
  query <- "{ \"territory\": { \"$exists\": \"true\" }}"
  cursor <- mongo.find(mongo, ns, query)
  dfTerritories <- mongo.cursor.to.data.frame(cursor)
  
  # Get the States data frame
  query <- "{ \"state\": { \"$exists\": \"true\" }}"
  cursor <- mongo.find(mongo, ns, query)
  dfStates <- mongo.cursor.to.data.frame(cursor)
  
  # Get the Federal Districts data frame
  query <- "{ \"federal_district\": { \"$exists\": \"true\" }}"
  cursor <- mongo.find(mongo, ns, query)
  dfDistricts <- mongo.cursor.to.data.frame(cursor)
  
  # Re-enable warnings 
  options(warn=0)  
  
  # Clean up dates to be Date data type.
  dfDistricts <- data.frame(dfDistricts, establishmentDate=as.Date(dfDistricts$establishment_date, "%m/%d/%Y"))
  dfStates <- data.frame(dfStates, statehoodDate=as.Date(dfStates$statehood_date, "%m/%d/%Y"))
  
  # Clean up extra quote marks and split the territorial status into two columns
  dfTerritories$territorial_status <- stringr::str_replace_all(dfTerritories$territorial_status, "\"", "")
  dfTerritoriesTidy <- tidyr::separate(dfTerritories, "territorial_status", c("is_incorporated", "is_organized"), sep=", ")

  # Show the clean data frames
  print(summary(dfStates))
  print(summary(dfDistricts))
  print(summary(dfTerritoriesTidy))
}


