#
#     Author: Daniel Dittenhafer
#
#     Created: Oct 5, 2014
#
# Description: Project 3 - Data Loading 
#

# Load the file into a data.frame
path <- file.path("C:/SourceCode/R/DataAcqMgmt/Week7/Data", "20141001140000.txt")
wiki.data <- read.table(path, header = FALSE, sep=" ")
colnames(wiki.data) <- c("language.proj", "page", "pageviews", "contentSize")

# Show me
head(wiki.data)

summary(wiki.data)
