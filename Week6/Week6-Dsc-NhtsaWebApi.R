#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 29, 2014
#
# Description: Data Science Context: Web APIs
#

#### 1. ####
# National Highway Traffic Safety Administration 
# http://www.nhtsa.gov/
# http://www.nhtsa.gov/webapi/Default.aspx?Recalls/API/83

#### 2. ####
# How might you use some or all of the data to create value in an application? 
# [One or two sentences]
#
# Answer: A simple application could let users register their vehicle(s) and the system
#         would notify them by email/text/etc of newly announced recalls.

#### 3. ####
# What problems might you encounter building an application that used this web
# site’s data? [One or two sentences]
# 
# Answer: The data/api is publiclly available, so a competing application might
#         already exist or appear on the market. Additionally, te NHTSA might 
#         change the WebAPI interface without much notice or begin charging for
#         access to the API. 
# 

#### 4. ####
# Write and share out a small R program that successfully pulls data from the 
# web site using the provided API.A very short “beachhead” program will receive
# 100% credit here!
# 
# using rjson
if(!require("rjson"))
{
  install.packages("rjson")
}
# using RCurl
if(!require("RCurl"))
{
  install.packages("RCurl")
}

theRootUrl <- "http://www.nhtsa.gov/webapi/api/Recalls/vehicle"

# What car?
year <- 2010
make <- "toyota"
model <- "Prius"

# Build the WebAPI URL
theApiUrl <-sprintf("%s/modelyear/%i/make/%s/model/%s?format=json", theRootUrl, year, make, model)

# Call the WebAPI and convert from JSON to list-of-lists.
carRecallsJson <- getURLContent(theApiUrl)
carRecalls <- fromJSON(carRecallsJson)

# Show the recall information for the specified vehicle
print(carRecalls)

#### 5. ####
# Include thoughts on your initial experience pulling data from this site. If 
# you were in charge of the site’s API, what would you have done differently.
#
# Answer: At this point I don't have any specific thoughts on how I would have 
#         defined this WebAPI differently. I like the fact that the API provides
#         calls to get the list of model years, makes, and models. This enables
#         a better user interface through dropdown lists or auto-completion.


