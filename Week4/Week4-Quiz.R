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
# Answer: Based on the chart plot, we might expect no relationship between 
#         length of movie and rating, but through a linear regression, it
#         appears there is a weak negative relationship between movie length
#         and rating.
#
#         A 95% Confidence Interval for the slope B1, the expected change in 
#         rating for a one minute increase in movie length, is -0.003039 through -0.002739.
#
# $B.hat
# [,1]
# B0  6.156014783
# B1 -0.002888827
# 
# $n
# [1] 58237
# 
# $SE
# [1] 7.665718e-05
# 
# $t.statistic
# B1 
# -37.68501 
# 
# $p.value
# B1 
# 4.43617e-307 
# 
# $confidence.interval
# lower.B1     upper.B1 
# -0.003039075 -0.002738578 
#
# First, use mean + 2 stdev as guide to remove outliers
upperThreshold <- (mean(movies$length) + ( 2 * sd(movies$length)))
print(upperThreshold)
moviesNoLengthOutliers <- subset(movies, movies$length <= upperThreshold)

# Build scatter plot for rating by length of movie
g3 <- ggplot(data=moviesNoLengthOutliers, aes(x=length, y=rating))
g3 <- g3 + geom_point()
g3 <- g3 + labs(title="Movie Rating by Length", x="Movie Length (minutes)", y="Average User Rating")
g3

# Helper function for simple linear regression.
my.linreg <- function(X, y, data, xcol, ycol, sigLevel)
{
  result <- list(B.hat = NA, n = NA, SE = NA, t.statistic = NA, p.value = NA, confidence.interval = NA)
  
  (result$B.hat <- solve( t(X) %*% X ) %*% t(X) %*% y  )  # solve takes the inverse
  rownames(result$B.hat) <- c("B0", "B1")
  
  # Properly, we should do an hypothesis test on Beta1 to determine if we can reject
  # the null hypothese that B1 = 0
  y.hat <- X %*% result$B.hat
  
  data2 <- cbind(data, y.hat)
  result$n <- nrow(data2)
  meanMovLength <- mean(data2[,xcol])

  # Standard Error
  result$SE <- sqrt( sum ( (data2[,ycol] - data2$y.hat) ^ 2) / result$n - 2 ) / sqrt( sum( (data2[,xcol] - meanMovLength) ^ 2) )
  
  # test statistic t
  result$t.statistic <- result$B.hat[2,1] / result$SE
  
  # p value 
  result$p.value <- 2 * pt(-abs(result$t.statistic), df=result$n - 1)
  
  # Confidence interval
  t.a <- abs(qt(sigLevel / 2, df=result$n - 2))
  result$confidence.interval <- c(lower = result$B.hat[2,1] - (t.a * result$SE), upper = result$B.hat[2,1] + (t.a * result$SE))
  
  # Return
  return (result)
}

# Run linear regression to see what it says
movies3 <- cbind(moviesNoLengthOutliers, ones=c(rep(1, nrow(moviesNoLengthOutliers))))
nOnesRating <- as.matrix(movies3[,c("ones", "length")])
X <- as.matrix(nOnesRating)
y <- as.matrix(movies3[,"rating"])

significanceLevel = 0.05
print(linRegInfo <- my.linreg(X, y, movies3, "length", "rating", significanceLevel))
print(sprintf("A %d%% Confidence Interval for the slope B1, the expected change in rating for a one minute increase in movie length, is %f through %f.", 
              (1 - significanceLevel) * 100, 
              linRegInfo$confidence.interval["lower.B1"], 
              linRegInfo$confidence.interval["upper.B1"]))

#### 4. ####
# Is there a relationship between length of movie and genre?
#
# Answer: Based on the results of the following R code and plot charts
#         the Animation and Short genres are 25 minutes or less, while
#         the other genres hover right around 90 minutes. As such,
#         I conclude there is a relationship between movie length and genre.
#
glData <- data.frame(genre=NULL, length=NULL)
for(g in genres)
{
  gl <- moviesNoLengthOutliers[moviesNoLengthOutliers[,g] == 1,]$length
  df <- data.frame(genre=c(rep(g, length(gl))), length=gl)
  glData <- merge(x=glData, y=df, all=TRUE)
  
}
print(head(glData))

# Build violin plot
g4 <- ggplot(data=glData, aes(x=genre, y=length))
g4 <- g4 + geom_violin(aes(group=genre))
g4 <- g4 + labs(title="Movie Length by Genre", x="Genre", y="Movie Length (minutes)")
g4

#### 5. ####
# Which other variable best predicts total number of votes that a movie received?
#
# Answer: Rating is a good predictor of votes based on both a visual inspection
#         and a linear regression, though the relationship falls apart above 
#         a rating of ~8.5 where very few votes equate to high ratings
#
#         A 95% Confidence Interval for the slope B1, the expected change in 
#         votes for a unit increase in rating, is 235.904710 through 275.557188.
#
# Build scatter plot for rating by length of movie
g5v <- ggplot(data=movies, aes(x=rating, y=votes))
g5v <- g5v + geom_point()
g5v <- g5v + labs(title="User Votes by Movie Rating", x="Rating", y="Votes")
g5v

movies5v <- cbind(movies, ones=c(rep(1, nrow(movies))))
onesRating <- as.matrix(movies5v[,c("ones", "rating")])
X <- as.matrix(onesRating)
y <- as.matrix(movies5v[,"votes"])

significanceLevel = 0.05
print(linRegInfo <- my.linreg(X, y, movies5v, "rating", "votes", significanceLevel))
print(sprintf("A %d%% Confidence Interval for the slope B1, the expected change in votes for a unit increase in rating, is %f through %f.", 
              (1 - significanceLevel) * 100, 
              linRegInfo$confidence.interval["lower.B1"], 
              linRegInfo$confidence.interval["upper.B1"]))
