#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 14, 2014
#
# Description: Answers to IS607 Week 4 Quiz
#
require(ggplot2)
require(ggthemes)

# Read in the data 
movies <- read.table("C:/SourceCode/R/DataAcqMgmt/MovieData/movies.tab", sep="\t", header=TRUE, quote="", comment="")

#### 1. ####
# Show an appropriate visualization that displays the total number of movies for each decade.
decade <- trunc(movies$year / 10) * 10
head(decade)
movies2 <- cbind(movies, as.factor(decade))
head(movies2)
g1 <- ggplot(data=movies2, aes(x=decade))
g1 <- g1 + geom_histogram(binwidth=5)
g1 <- g1 + labs(title="Movies per Decade", x="Decade", y="Movies")
g1

#### 2. ####
# Show the average IMBD user rating for different genres of mivies. Has this changed over time?


#geom_bar(aes(color = factor(year)))


#ggplot(data=movies) + geom_histogram(aes(x = budget))
#ggplot(data=movies) + geom_histogram(aes(x = length))
#ggplot(data=movies) + geom_histogram(aes(x = rating))
#ggplot(data=movies, aes(x=rating, y = votes)) + geom_point() + geom_point(aes(color=mpaa))

