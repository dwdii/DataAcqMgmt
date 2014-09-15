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
# Answer: Yes, ratings have changed over time. Based on the faceted chart 
#         produced by the following code, each genre has had it's own 
#         fluctuations through the decades, though all genres generally
#         saw a signficant increase in average rating during the 1900 and 
#         1910 decades.
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

# Build faceted chart by genre showing how ratings have changed over time.
g2 <- ggplot(data=ratingOverTime, aes(x=decade, y=avg.rating))
g2 <- g2 + geom_line(aes(group=1))
g2 <- g2 + facet_wrap(~ genre)
g2 <- g2 + theme(axis.text.x = element_text(angle=45, vjust=1))
g2 <- g2 + labs(title="Average User Ratings for Movies by Genre per Decade", x="Decade", y="Average User Rating")
g2

#### 3. ####
# Is there a relationship between length of movie and movie rating?
#
# Answer: No, length of movie and rating has no relationship.
#
# First, use mean + 2 stdev as guide to remove outliers
upperThreshold <- (mean(movies$length) + ( 2 * sd(movies$length)))
print(upperThreshold)
moviesNoLengthOutliers <- subset(movies, movies$length <= upperThreshold)

# Build scatter plot for rating by length of movie
g3 <- ggplot(data=moviesNoLengthOutliers, aes(x=length, y=rating))
g3 <- g3 + geom_point()
g3 <- g3 + labs(title="Movie Rating by Length", x="Length", y="Average User Rating")
g3

my.linreg <- function(X, y, data, xcol, ycol)
{
  result <- list(B.hat = NA, n = NA, SE = NA, t.statistic = NA, p.value = NA)
  
  (result$B.hat <- solve( t(X) %*% X ) %*% t(X) %*% y  )  # solve takes the inverse
  rownames(result$B.hat) <- c("B0", "B1")
  print(result$B.hat)
  
  # Properly, we should do an hypothesis test on the Betas to determine if we can accept
  # the alternate hypothesis that B1 is != 0... but for now, we will take the value at 
  # its face value.
  
  y.hat <- X %*% result$B.hat
  print(head(y.hat))
  
  data2 <- cbind(data, y.hat)
  result$n <- nrow(data2)
  meanMovLength <- mean(data2[,xcol])
  
  result$SE <- sqrt( sum ( (data2[,ycol] - data2$y.hat) ^ 2) / result$n - 2 ) / sqrt( sum( (data2[,xcol] - meanMovLength) ^ 2) )
  print(result$SE)  
  
  result$t.statistic <- result$B.hat[2,1] / result$SE
  
  result$p.value <- pt(-abs(result$t.statistic), df=result$n - 1)
  
  return (result)
}

# Run linear regression to see that it says
movies3 <- cbind(moviesNoLengthOutliers, ones=c(rep(1, nrow(moviesNoLengthOutliers))))
nOnesRating <- as.matrix(movies3[,c("ones", "length")])
#print(mode(nOnesRating))
#print(class(nOnesRating))
X <- as.matrix(nOnesRating)
y <- as.matrix(movies3[,"rating"])

print(my.linreg(X, y, movies3, "length", "rating"))
# ones    6.021470578
# length -0.001076301
#
