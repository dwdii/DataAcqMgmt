#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 29, 2014
#
# Description: Week 6 Assignment
#

library(rvest)
theURL <- "http://www.kaggle.com/c/bike-sharing-demand/leaderboard"
bikeShareHtml <- html(theURL)

leaderboard <- bikeShareHtml %>% 
  html_node("#leaderboard-table") %>% html_table(fill=TRUE) 

dim(leaderboard)
# [1] 857   6

summary(leaderboard)
# #             Δ1w            Team Name\r\n                \r\n                                            * in the money     Score       
# Min.   :  1.0   Length:857         Length:857                                                                                  Min.   :0.2882  
# 1st Qu.:214.8   Class :character   Class :character                                                                            1st Qu.:0.4707  
# Median :428.5   Mode  :character   Mode  :character                                                                            Median :0.5441  
# Mean   :428.5                                                                                                                  Mean   :0.7840  
# 3rd Qu.:642.2                                                                                                                  3rd Qu.:0.8209  
# Max.   :856.0                                                                                                                  Max.   :4.7619  
# NA's   :1                                                                                                                                      
#     Entries        Last Submission UTC (Best − Last Submission)
#  Min.   :  1.000   Length:857                                  
#  1st Qu.:  2.000   Class :character                            
#  Median :  5.000   Mode  :character                            
#  Mean   :  9.664                                               
#  3rd Qu.: 12.000                                               
#  Max.   :391.000                                               
#  NA's   :1      

head(leaderboard)

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
