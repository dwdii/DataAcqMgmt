#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 8, 2014
#
# Description: Answers to IS607 Week 3 Assignment
#

#### 1. ####
# Write a function that takes a vector as input and returns the number of 
# missing values in the vector. * assuming a numeric vector *
num.missing <- function(numVector)
{
  # Local Vars
  result <- NULL
  
  # Validate param
  if(!is.numeric(numVector))
  {
    print("The input vector must be numeric.")
  } else
  {
    sortedV <- sort(numVector)
    expected <- seq(min(sortedV), max(sortedV))
    missing <- length(expected) - length(sortedV)
    result <- missing
  }

  # Return
  return(result)
}
t1 <- c(12,10,11,14,13,20)
(num.missing(t1))
# [1] 5

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
  result <- sapply(df, num.missing)
  
  # Return 
  return(result)
}
t2 <- data.frame(first=c(12,10,11,14,13,20), second=c(21,22,4,5,8,7))
(r2 <- dnum.missing(t2))
#  first second 
#      5     13 

#### 3. ####
# Write a function that takes a numeric vector as input and uses it to determine
# the minimum, the maximum, the mean, the median, the first quartile, the third 
# quartile, the standard deviation of the vector. and the number of missing values. 
# Do not use any built in functions to do this. Return a named list with the eight
# desired values in an order you deem best. You may if you like use the function
# you wrote for question 1.
get.stats <- function(numVector)
{
  # Local Vars
  vecLength <- length(numVector)
  result <- list(min=NA, max=NA, sum=NA, mean=NA, median=NA, firstQ=NA, thirdQ=NA, stdev=NA, missing=NA)
  
  sorted <- sort(numVector)
  print(sorted)
  
  result$min <- sorted[1]
  result$max <- sorted[length(sorted)]
  result$sum <- sum(numVector)
  
  # Mean
  if(0 < vecLength)
  {
    result$mean <- result$sum / vecLength
  }
  
  # Median
  mid <- vecLength / 2
  print(mid)
  if(vecLength %% 2 == 0)
  {
    
    ndx1 <- mid
    ndx2 <- mid + 1
    result$median <- (sorted[ndx1] + sorted[ndx2]) / 2
  } else
  {
    ndx <- round(mid, 0) 
    result$median <- sorted[ndx]
  }
  
  # Quartiles
  quartile <- function(m, v)
  {
    ndx <- (m * length(v)) / 4
    if(ndx - trunc(ndx) == 0)
    {
      q <- (v[ndx] + v[ndx + 1]) / 2
      
    } else
    {
      ndx <- ceiling(ndx)
      q <- v[ndx] 
    }   
    
    return(q)
  }
  
  # First Q
  result$firstQ <- quartile(1, sorted)
  
  # Third Q
  result$thirdQ <- quartile(3, sorted)
  
  # Return
  return(result)
}
t3 <- c(12,10,11,14,13,20,23)
(r3 <- get.stats(t3))
