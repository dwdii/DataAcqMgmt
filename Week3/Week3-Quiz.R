#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 6, 2014
#
# Description: Answers to Week 3 Quiz
#

#### 1. ####
# Write a function that takes a numeric vector and calculates the mean of the observations in the vector.
calculate.mean <- function(values)
{
  # Local Vars
  mean <- NA
  count <- length(values)
  
  # Only if we have one or more values
  if(0 < count)
  {
    mean <- sum(values) / count
  }

  # Return
  return(mean)
}

calculate.mean(c(10,20,30,40))
# [1] 25


#### 2. ####
# Modify your fuction in the previous question so that it can handle a numeric
# vector with missing values
calculate.mean2 <- function(values)
{
  # Local Vars
  mean <- NA
  values2 <- subset(values, !is.na(values))
  count <- length(values2)
  
  # Only if we have one or more values
  if(0 < count)
  {
    mean <- sum(values2) / count
  }
  
  # Return
  return(mean)
}

calculate.mean2(c(10,20,30,40, NA))

#### 3. ####
# Write a function that takes two numeric input values and calculates the 
# greatest common divisor of the two numbers
calculate.GCD <- function()
{
  
}