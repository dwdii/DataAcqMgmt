#
#     Author: Daniel Dittenhafer
#
#     Created: Oct 5, 2014
#
# Description: Project 3 - Data Loading 
#
require("RPostgreSQL")

# Load the file into a data.frame
path <- file.path("C:/Code/R/DataAcqMgmt/Week7/Data", "20141001140000.txt")
wiki.data <- read.table(path, header = FALSE, sep=" ")
colnames(wiki.data) <- c("language.proj", "page", "pageviews", "contentSize")

# Show me
head(wiki.data)

summary(wiki.data)

languages <- levels(as.factor(wiki.data$language.proj))

# PostgreSQL Version: 9.3.5.1
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv,user="postgres",password="a",dbname="wikidata")

# Insert the languages in the language table.
for (l in languages)
{
  sQuery <- sprintf("SELECT id FROM language WHERE languagecode = '%s'", l)
  print (sQuery)
  res <- dbGetQuery(con, sQuery)
  print(head(res))
  
  if(0 < nrow(res))
  {
    # found it
  }
  else
  {
    sInsert <- sprintf("INSERT INTO language (languagecode) VALUES ('%s') RETURNING id", l)
    res <- dbGetQuery(con, sInsert)
  }
}

if(dbExistsTable(con, "rawstage")){
  dbRemoveTable(con, "rawstage")
}

dbWriteTable(con, "rawstage", wiki.data)



