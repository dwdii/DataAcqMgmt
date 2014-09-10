#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 8, 2014
#
# Description: Answers to IS607 Week 3 Assignment
#

#### 1. ####
# Write a function that takes a vector as input and returns the number of 
# missing values in the vector. IE - Count # of NAs
num.missing <- function(v)
{
  # Local Vars
  result <- NULL
  
  # Validate param
  if(!is.vector(v))
  {
    stop("The input parameter must be vector.")
  } else
  {
    missing <- is.na(v)
    result <- sum(missing)
  }

  # Return
  return(result)
}
t1 <- c(12,10,11,NA,13,20,NA)
(num.missing(t1))
# [1] 2

#### 2. ####
# Write a function that takes a data frame as input and returns a named vector 
# with the number of missing values in each column of the data frame. The names
# of the entries should be the corresponding column names of the data frame.
# You may use the function from the previous question as part of  your solution.
dnum.missing <- function(df)
{
  # Local Vars
  result <- NULL
  
  # Apply our num.missing function across the input data.frame
  result <- lapply(df, num.missing)
  
  # Return 
  return(result)
}
t2 <- data.frame(first=c(12,10,11,14,13,20, NA), second=c(21,22,4,5,8,7, NA), third=c(NA,NA,1,NA,NA,NA,NA))
(r2 <- dnum.missing(t2))
# $first
# [1] 1
# 
# $second
# [1] 1
# 
# $third
# [1] 6

#### 3. ####
# Write a function that takes a numeric vector as input and uses it to determine
# the minimum, the maximum, the mean, the median, the first quartile, the third 
# quartile, the standard deviation of the vector. and the number of missing values. 
# Do not use any built in functions to do this. Return a named list with the eight
# desired values in an order you deem best. You may if you like use the function
# you wrote for question 1.
get.numericStats <- function(numVector)
{
  # Local Vars
  result <- list(min=NA, max=NA, sum=NA, mean=NA, median=NA, firstQ=NA, thirdQ=NA, stdev=NA, missing=NA)
  sorted <- sort(numVector)
  vecLength <- length(sorted)
  
  # Start populating the output
  result$min <- sorted[1]
  result$max <- sorted[vecLength]
  result$sum <- sum(sorted)
  
  # Mean
  if(0 < vecLength)
  {
    result$mean <- result$sum / vecLength
  }
  
  # Median
  myMedian <- function(v)
  {
    medres <- NA
    l <- length(v)
    mid <- l / 2
    if(l %% 2 == 0)
    {
      
      ndx1 <- mid
      ndx2 <- mid + 1
      medres <- (v[ndx1] + v[ndx2]) / 2
    } else
    {
      ndx <- round(mid, 0) 
      medres <- v[ndx]
    }
    
    return (medres)
  }
  result$median <- myMedian(sorted)
  
  # Quartiles
  # Using "Inclusive" Method 1 from: http://www.amstat.org/publications/jse/v14n3/langford.html
  quartile <- function(m, v)
  {
    odd <- (length(v) %% 2) != 0
    half <- length(v) / 2
    if(odd)
    {
      half <- ceiling(half)
    }
    
    if(m == 1)
    {
      qset <- v[1:half]
      
    } else if (m == 3)
    {
      if(!odd)
      {
        half <- half + 1
      }
      qset <- v[half : length(v)]
    }
    
    q <- myMedian(qset)
    
    return(q)
  }
  
  # First Q
  result$firstQ <- quartile(1, sorted)
  
  # Third Q
  result$thirdQ <- quartile(3, sorted)
  
  # Standard Deviation (of Sample)
  diffMean <- sorted - result$mean
  diffMeanSqr <- diffMean ^ 2
  sumDiffMeanSqr <- sum(diffMeanSqr)
  variance <- sumDiffMeanSqr / (vecLength - 1)
  result$stdev <- sqrt(variance)
  
  # Num of missing
  result$missing <- num.missing(numVector)
  
  # Return
  return(result)
}
t3 <- c(12,10,11,14,13,20, NA)
(r3 <- get.numericStats(t3))
# $min
# [1] 10
# 
# $max
# [1] 20
# 
# $sum
# [1] 80
# 
# $mean
# [1] 13.33333
# 
# $median
# [1] 12.5
# 
# $firstQ
# [1] 11
# 
# $thirdQ
# [1] 14
# 
# $stdev
# [1] 3.559026
# 
# $missing
# [1] 5

#### 4. ####
# Write a function that takes a character or factor vector and determines the 
# number of distinct elements in the vector, the most commonly occuring 
# element, the number of times the most commonly occuring element occurs, 
# and the number of missing values. Be sure to handle ties gracefully. Have the
# function return a named list with the desired information in a logical order.
get.factorInfo <- function(v)
{
  result <- list(numDistinct=NA, mostCommon=NA, numOfMostCommon=NA, missing=NA)
  if(!is.character(v) && !is.factor(v))
  {
    stop("Input vector v must be either a character or factor vector.")
  } else
  {
    if(is.factor(v))
    {
      asFact <- v
    } else
    {
      asFact <- as.factor(v)
    }
    
    theLevels <- data.frame(x=levels(asFact))
    
    # NUmber of Distinct Elements
    result$numDistinct = length(levels(asFact))
    
    # Most Common
    theCounts <- plyr::count(asFact)
    fullCounts <- merge(theCounts, theLevels, by="x", all=TRUE)
    sortedCounts <- plyr::arrange(theCounts, freq, decreasing=TRUE)
    result$mostCommon = as.character(sortedCounts[sortedCounts$freq == max(sortedCounts$freq),1])
    result$numOfMostCommon = sortedCounts[1,2]
    
    # How to determine missing values from a character or factor vector?
    # here we use the differece between full list (includes all levels)
    # and the sorted counts list which doesn't have the NAs
    result$missing = num.missing(as.character(v))
  }
  
  return(result)
}
t4 <- factor(c("a","b","c","d", "a", "a", "d", "a", "e",NA,"d"), levels=c("a","b","c","d", "e","f", "g", "m"))
(get.factorInfo(t4))
# $numDistinct
# [1] 8
# 
# $mostCommon
# [1] "a"
# 
# $numOfMostCommon
# [1] 4
# 
# $missing
# [1] 1

t4.2 <- c("a","b","c","d", "a", "a", "d", "a", NA,"m","d","d")
(get.factorInfo(t4.2))
# $numDistinct
# [1] 5
# 
# $mostCommon
# [1] "a" "d"
# 
# $numOfMostCommon
# [1] 4
# 
# $missing
# [1] 1

#### 5. ####
# Write a function that takes a logical vector and determines the number of 
# true values, the number of false values, the proportion of true values, and 
# the number of missing values. Have the function return a named list with the
# desired information in a logical order.
get.logicalInfo <- function(logicalV)
{
  # Local Vars
  result <- list(numTrue=NA, numFalse=NA, ratioTrue=NA, missing=NA)
  
  if(0 < length(logicalV))
  {
    sorted <- sort(logicalV)
    vLength <- length(sorted)
    
    result$numTrue = sum(sorted)
    result$numFalse = vLength - result$numTrue
    result$ratioTrue = result$numTrue / vLength
    
    # Benefit from the fact that NAs drop out during sort.
    result$missing = length(logicalV) - vLength 
  }
  
  return (result)
}
t5 <- c(TRUE, NA, FALSE, TRUE, FALSE, TRUE)
(get.logicalInfo(t5))
# $numTrue
# [1] 3
# 
# $numFalse
# [1] 2
# 
# $ratioTrue
# [1] 0.6
# 
# $missing
# [1] 1


t5.2 <- c()
(get.logicalInfo(t5))
# $numTrue
# [1] NA
# 
# $numFalse
# [1] NA
# 
# $ratioTrue
# [1] NA
# 
# $missing
# [1] NA

#### 6.####
# Write a function that takes as its input a data frame and returns a summary 
# of its columns using the functions you write for questions 3-5. You may 
# assume that all columns will be of the three types in those questions. You 
# are expected to use the functions you have written in the previous questions,
# so you do no have to write them again by scratch. Return the desired 
# information in a format that you deem best. One suggestion would be a named
# list of lists, but I leave it your judgement.
get.df.info <- function(df)
{
  result <- vector("list", length(df))
  names(result) <- names(df)
  
  for(i in names(df))
  {
    if(is.factor(df[,i]))
    {
      result[[i]] <- get.factorInfo(df[,i])
    } else if(is.numeric(df[,i]))
    { 
      result[[i]] <- get.numericStats(df[,i])
    }
    else if(is.logical(df[,i]))
    {
      result[[i]] <- get.logicalInfo(df[,i])
    }
    else if(is.character(df[,i]))
    {
      result[[i]] <- get.factorInfo(df[,i])
    }
  }
  
  return(result)
}
b1 <- c(TRUE, FALSE, NA)
c1 <- c("a", "b", "c")
f1 <- factor(c("z", "y", "x"))
n1 <- c(10, 20, 30)
df6 <- data.frame(b1=b1, f1=f1, c1=c1, n1=n1, stringsAsFactors=FALSE)
(get.df.info(df6))
# $b1
# $b1$numTrue
# [1] 1
# 
# $b1$numFalse
# [1] 1
# 
# $b1$ratioTrue
# [1] 0.5
# 
# $b1$missing
# [1] 1
# 
# 
# $f1
# $f1$numDistinct
# [1] 3
# 
# $f1$mostCommon
# [1] "x" "y" "z"
# 
# $f1$numOfMostCommon
# [1] 1
# 
# $f1$missing
# [1] 0
# 
# 
# $c1
# $c1$numDistinct
# [1] 3
# 
# $c1$mostCommon
# [1] "a" "b" "c"
# 
# $c1$numOfMostCommon
# [1] 1
# 
# $c1$missing
# [1] 0
# 
# 
# $n1
# $n1$min
# [1] 10
# 
# $n1$max
# [1] 30
# 
# $n1$sum
# [1] 60
# 
# $n1$mean
# [1] 20
# 
# $n1$median
# [1] 20
# 
# $n1$firstQ
# [1] 15
# 
# $n1$thirdQ
# [1] 25
# 
# $n1$stdev
# [1] 10
# 
# $n1$missing
# [1] 0