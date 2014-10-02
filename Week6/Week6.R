#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 29, 2014
#
# Description: Week 6 Assignment
#

library(rvest)

# Using the Kaggle Bike Sharing Demand competition leaderboard as the test bed 
# for this exercise.
theURL <- "http://www.kaggle.com/c/bike-sharing-demand/leaderboard"
bikeShareHtml <- html(theURL)

# Parse and extract the leaderboard table
leaderboard <- bikeShareHtml %>% 
  html_node("#leaderboard-table") %>% html_table(fill=TRUE) 

# Show dimensions
dim(leaderboard)
# [1] 857   6

# And summary
summary(leaderboard)
   
# Show the data.frame in RStudio's data viewer.
leaderboard %>% View()

# Print out the team that is currently in first place and their score.
print(sprintf("The current team in first place for the Bike Sharing Demand Competition is %s with a score of %f", 
              stringr::word(stringr::str_trim(leaderboard[1,3]))[1], leaderboard[1,4]))

#### Optional ####
# list all avalable demos
demo(package="rvest")

#lists code for tripadvisor demo;
demo("tripadvisor", "rvest")

#### Optional Advanced ####
# Use other R packages (such as XML and RCurl) to pull down the same data as above.
# Briefly compare your experience.
#
#  Answer: The XML::readHTMLTable function produced very similar results to the rvest code above.
#          In this case, XML::readHTMLTable seems like the simplier choice, but obviously rvest
#          has a much more powerful set of tools for extracting specific details from a given
#          webpage. 
#
#          The RCurl::getURLContent function fetches the raw HTML, but then it is up to the caller
#          to find a way to parse out the desired subset of the page. This can be quite a headache.
# 
library(XML)
ldrTable <- readHTMLTable(theURL)
ldrTable

library(RCurl)
rcLdrTable <- getURLContent(theURL)
rcLdrTable
