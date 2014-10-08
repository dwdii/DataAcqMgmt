#
#     Author: Daniel Dittenhafer
#
#     Created: Oct 7, 2014
#
# Description: Project 3 - Data Loading 
#
require("RPostgreSQL")

# PostgreSQL - connect
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv,user="postgres",password="a",dbname="wikidata")

# COALESCE(pv1.pageviews, 0) 
sQuery <- "SELECT l.languagecode, p.page, COALESCE(pv1.pageviews, 0) AS pageviews1, COALESCE(pv2.pageviews, 0) AS pageviews2, COALESCE(pv2.pageviews, 0) - COALESCE(pv1.pageviews, 0) as delta FROM page p LEFT JOIN pageviews pv1 ON pv1.pageid = p.id AND pv1.hourstamp = '2008-10-01 01:00:00' LEFT JOIN pageviews pv2 ON pv2.pageid = p.id AND pv2.hourstamp = '2008-10-03 02:00:00' LEFT JOIN language l ON l.id = p.languageid WHERE COALESCE(pv1.pageviews, 0) > 1000 OR COALESCE(pv2.pageviews, 0) > 1000 ORDER BY delta DESC LIMIT 5" 
print (sQuery)
res <- dbGetQuery(con, sQuery)

head(res)

require(ggplot2)
g2 <- ggplot(data=res, aes(x=factor(page), y=delta))
g2 <- g2 + geom_bar(stat="identity")
g2 <- g2 + theme_minimal()
g2 <- g2 + scale_x_discrete(labels=as.character(res$page), limits=as.character(res$page))
g2 <- g2 + theme(axis.text.x = element_text(angle=30, vjust=1))
g2 <- g2 + labs(title="Wikipedia Stats, Top 5 Change in Page Views  Oct 1, 1AM - Oct 3, 2AM, 2008", x="page", y="delta page views")
g2
