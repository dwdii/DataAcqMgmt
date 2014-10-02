#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 28, 2014
#
# Description: Answers to IS607 Week 6 Quiz
#
# week6quiz.R
# [For your convenience], here is the provided code from Jared Lander's R for Everyone, 
# 6.7 Extract Data from Web Sites

# install.packages("XML")
require(XML)
theURL <- "http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlPool <- readHTMLTable(theURL, which = 1, header = FALSE, stringsAsFactors = FALSE)
bowlPool

#### 1. ####
# What type of data structure is bowlpool? 
#
# Answer: bowlPool is a data.frame with 10 rows and 3 columns
#
mode(bowlPool)
# [1] "list"
class(bowlPool)
# [1] "data.frame"
dim(bowlPool)
# [1] 10  3

#### 2. ####
# Suppose instead you call readHTMLTable() with just the URL argument,
# against the provided URL, as shown below
theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL)

# What is the type of variable returned in hvalues?
#
# Answer: hvalues is a list.
#
mode(hvalues)
# [1] "list"
class(hvalues)
# [1] "list"
dim(hvalues)
# NULL


#### 3. ####
# Write R code that shows how many HTML tables are represented in hvalues
#
# Answer: 7 tables are indicated by the presence of 7 list items in hvalues,
#         but only 2 of those tables are actually represented in hvalues with
#         their contents.
#
length(hvalues)
# [1] 7

#### 4. ####
# Modify the readHTMLTable code so that just the table with Number, 
# FirstName, LastName, # and Points is returned into a dataframe
pplPointsDf <- readHTMLTable(theURL, which = 1, header = TRUE, stringsAsFactors = FALSE)
pplPointsDf

#   Number First Name Last Name Points
# 1      1        Eve   Jackson     94
# 2      2       John       Doe     80
# 3      3       Adam   Johnson     67
# 4      4       Jill     Smith     50

#### 5. ####
# Modify the returned data frame so only the Last Name and Points columns are shown.
pplPointsDf <- pplPointsDf[, c("Last Name", "Points")]
pplPointsDf

#   Last Name Points
# 1   Jackson     94
# 2       Doe     80
# 3   Johnson     67
# 4     Smith     50

#### 6. ####
# Identify another interesting page on the web with HTML table values.  
# This may be somewhat tricky, because while
# HTML tables are great for web-page scrapers, many HTML designers now prefer 
# creating tables using other methods (such as <div> tags or .png files).  
theURL <- "http://www.bls.gov/data/"

#### 7 ####
# How many HTML tables does that page contain?
#
# Answer: the BLS Data Government web page has 16 tables.
#
hBlsGovData <- readHTMLTable(theURL)
length(hBlsGovData)
# [1] 16

# 8 Identify your web browser, and describe (in one or two sentences) 
# how you view HTML page source in your web browser.
#
# Answer: I am using a combination of Internet Explorer v11 and Chrome v37.
#          - In IE, I right click and select the "View source" menu item or 
#            press F12 to open Developer Tools
#          - In Chrome, right click > View Page Source, or View > Developer > 
#            Developer Tools
