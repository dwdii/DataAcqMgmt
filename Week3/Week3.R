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