#
#     Author: Daniel Dittenhafer
#
#     Created: Oct 5, 2014
#
# Description: Project 3 - Data Loading 
#
# Hour files used:
#   pagecounts-20081003-020000
#   pagecounts-20081001-010000
#
require("RPostgreSQL")

# Load the file into a data.frame
path <- file.path("C:/SourceCode/R/DataAcqMgmt/Week7/Data", "20141001140000.txt")
hourstamp = '2014-10-01 14:00:00'
#path <- file.path("C:/Users/Dan/Downloads/Wikidata", "pagecounts-20081003-020000")
#hourstamp = '2009-10-03 02:00:00'
wiki.data <- read.table(path, header = FALSE, sep=" ", stringsAsFactors=FALSE, fill=TRUE)
colnames(wiki.data) <- c("language", "page", "pageviews", "contentsize")

# Show me
head(wiki.data)
summary(wiki.data)

#wiki.data2 <- tidyr::separate(wiki.data, language.proj, into = c("language", "project"), sep="[^a-z\\.]", convert=FALSE, remove=FALSE, fixed=TRUE)
#head(wiki.data2)
#wiki.data2 <- tidyr::extract(wiki.data, col="language", into = c("language", "project"), regex="([[:alnum:]]+)\\.([[:alnum:]]+)")
wiki.data2 <- wiki.data

#colnames(wiki.data2) <- c("language", "page", "pageview")

# Get unique languages
languages <- levels(as.factor(wiki.data2$language))
wiki.data3 <- cbind(wiki.data2, langid=NA)

# PostgreSQL - connect
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv,user="postgres",password="a",dbname="wikidata")

# Insert the languages in the language table.
langIds <- data.frame(language=NULL, id=NULL)
for (l in languages)
{
  if(!stringr::str_detect(l, "[\\.]"))
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
      print (sInsert)
      res <- dbGetQuery(con, sInsert)
      
    }

    # Keep the lang Ids and update our data.frame accordingly.
    langIds <- rbind(langIds, language = l, id = res[1,1])
    wiki.data3[wiki.data3$language == l,]$langid <- res[1,1]
  }
}

# Show me
head(langIds)
head(wiki.data3)

# Remove the non-wikipedia rows.
wiki.data4 <- subset(wiki.data3, !is.na(wiki.data3$langid))
head(wiki.data4)

# Bulk insert the raw data into a staging table.
if(dbExistsTable(con, "rawstage")){
  dbRemoveTable(con, "rawstage")
}
dbWriteTable(con, "rawstage", wiki.data4)

# Now swap the page data into the page table
sQuery <- sprintf("INSERT INTO page (page, languageid, pagemd5) SELECT r.page, CAST(langid AS INT), md5(r.page) FROM rawstage r LEFT JOIN page p ON p.pagemd5 = md5(r.page) AND p.languageid = r.langid WHERE p.id IS NULL GROUP BY r.page, langid")
print (sQuery)
res <- dbGetQuery(con, sQuery)

# Finally swap the pageviews data into the pageviews table
sQuery <- sprintf("INSERT INTO pageviews (hourstamp, pageid, pageviews, contentsize) SELECT '%s', p.id, SUM(r.pageviews), MAX(r.contentsize) FROM rawstage r INNER JOIN page p ON p.pagemd5 = md5(r.page) AND p.languageid = r.langid LEFT JOIN pageviews pv ON pv.pageid = p.id AND pv.hourstamp = '%s' WHERE pv.id IS NULL GROUP BY p.id", hourstamp, hourstamp)
#sQuery <- sprintf("SELECT '%s', 1, pageviews, contentsize FROM rawstage r", hourstamp)
print (sQuery)
res <- dbGetQuery(con, sQuery)

# 
sQuery <- "SELECT p.page, pv.pageviews FROM page p LEFT JOIN pageviews pv ON pv.pageid = p.id ORDER BY pv.pageviews DESC LIMIT 10"
print (sQuery)
res <- dbGetQuery(con, sQuery)

head(res)


