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
#
# Create a vector with the decade 
decade <- trunc(movies$year / 10) * 10

# Bind decade to the data
movies2 <- cbind(movies, decade=decade)

# Build the chart
g1 <- ggplot(data=movies2, aes(x=decade))
g1 <- g1 + geom_histogram(binwidth=5)
g1 <- g1 + labs(title="Movies per Decade", x="Decade", y="Movies")
g1

#### 2. ####
# Show the average IMBD user rating for different genres of movies. Has this changed over time?
#
# First, helper function for determining average rating per genre for a set of movies.
get.avgRating <- function(genres, someMovies)
{
  avgRating <- data.frame(genre=genres, avg.rating=c(rep(NA, length(genres))))
  for(g in genres)
  {
    avgRating$avg.rating[avgRating$genre ==g] = mean(as.numeric(someMovies$rating[someMovies[g] == 1]))
  }

  return(avgRating)
}
# Labels
genres <- c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short")
decades <- levels(as.factor(decade))

# Allocate the data frame that will receive all the data
ratingOverTime <- data.frame(genre=NA, decade=NA, avg.rating=NA)

# Loop over decades to produce aggreagted ratings
for (d in decades)
{
  theMovies <- movies2[movies2$decade == d,]
  decadeRatings <- get.avgRating(genres, theMovies)
  
  decadeRatings <- cbind(decadeRatings, decade=c(rep(d, length(genres))))
  
  ratingOverTime <- merge(x=ratingOverTime, y=decadeRatings, all=TRUE)
}

# Eliminate NAs
ratingOverTime <- subset(ratingOverTime, !is.na(ratingOverTime$genre))

# Build faceted chart by genra showing how ratings have changed over time.
g2 <- ggplot(data=ratingOverTime, aes(x=decade, y=avg.rating))
g2 <- g2 + geom_line(aes(group=1))
g2 <- g2 + facet_wrap(~ genre)
g2 <- g2 + theme(axis.text.x = element_text(angle=45, vjust=1))
g2 <- g2 + labs(title="Average User Ratings for Movies by Genre per Decade", x="Decade", y="Average User Rating")
g2
