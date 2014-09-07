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
calculate.GCD <- function(n1, n2)
{
  # Create sequences 1 - each number
  n1.seq <- seq(1,n1)
  n2.seq <- seq(1,n2)
  
  # Determine which greater for later.
  max <- ifelse( n1 < n2, n1, n2)
  
  # Use Modulus to find evenly divisible.
  n1.mod <- n1 %% n1.seq
  n2.mod <- n2 %% n2.seq
  
  # Convert to boolean
  n1.bit <- n1.mod == 0
  n2.bit <- n2.mod == 0
  
  # "And" the two vectors using the smaller size
  common.divisor.bits <- n1.bit[1:max] & n2.bit[1:max]
  
  # determine indices of the "true" bits
  common.divisors <- which(common.divisor.bits)
  
  # Which common divisor is greatest?
  theGcd = max(common.divisors)
  
  # Return
  return(theGcd)
}
calculate.GCD(56,42)
# [1] 14

#### 4. ####
# Write a function that implements Euclid's Algorithm
# Using Euclid's Algoritm
calculate.GcdEuclid <- function(n1, n2)
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

(calculate.GcdEuclid(42,56))

#### 5. ####
# Write a function that takestwo numeric inputs x and y and calculates x^2 * y + 2xy - xy^3

# [1] 14