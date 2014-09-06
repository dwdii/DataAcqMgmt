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
# [1] 25

#### 3. ####
# Write a function that takes two numeric input values and calculates the 
# greatest common divisor of the two numbers
# 
# Using Euclid's Algoritm
calculate.GCD <- function(n1, n2)
{
  gcd <- NULL
  
  # Calculate the remainder of division
  modulus <- n1 %% n2
  
  # If zero, then 
  if(modulus == 0)
  {
    # finally found the GCD
    gcd <- n2
  } else
  {
    # recursive function to keep looking
    gcd = calculate.GCD(n2, modulus) 
  }
  
   # Return
  return(gcd)
}

(calculate.GCD(42,56))
# [1] 14

#### 4. ####
# Write a function that implements Euclid's Algorithm
