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
# [1] 14

#### 5. ####
# Write a function that takes two numeric inputs x and y and calculates x^2 * y + 2xy - xy^3
calculate.5 <- function(x, y)
{
  # R executes in PEMDAS order, so this works nicely.
  return (x^2 * y + 2 * x * y - x * y^3)
}
calculate.5(2,2)

#### 6. ####
# Read in the week-3-price-data.csv and week-3-make-model-data.csv files as 
# data frames and then merge them by the ModelNumber key. Leave the "all" 
# parameters as their defaults. 
#
# How many observations end up in the result? 
# Answer: 27
#
# Is this what you would have expected? 
# Answer: I had no expectation per se, but now looking the data more
#         closely, I see that on of the price data ModelNumber=23120 does
#         not appear in the model data set. The merge function appears
#         to be doing an "inner join" (in SQL terms) by default, so the
#         23120 row gets dropped out.
path <- file.path("C:/SourceCode/R/DataAcqMgmt/Week3", "week-3-price-data.csv")
price.data <- read.table(path, header = TRUE, sep=",")

path <- file.path("C:/SourceCode/R/DataAcqMgmt/Week3", "week-3-make-model-data.csv")
model.data <- read.table(path, header = TRUE, sep=",")
#(test <- model.data[model.data$Year == 2010, ] )

result6 <- merge(price.data, model.data, by="ModelNumber")
result6[0]

#### 7. ####
# Us the data sets from the previous question, but this time merge 
# them so that the rows from the price-data table all appear, even if 
# there is no match in the make-model data.
result7 <- merge(price.data, model.data, by="ModelNumber", all=TRUE)
result7[0]

#### 8. ####
# Take y our result from question 7 and subset it so that only the 2010 
# vehicles are included.
result8 <- result7[result7$Year == 2010, ]
(result8 <- result8[!is.na(result8$Year), ])

#### 9. ####
# Take your result from question 7 and subset it so that only the red cars that
# cost move than $10,000 are included.
(result9 <- result7[result7$Price > 10000, ])

#### 10. ####
# Take your result from question 9 and subset it so that the ModelNumber and 
# Color columns are removed.
(result10 <- with(result9, data.frame(ID, Mileage, Price, Make, Model, Year)))
  
#### 11. ####
# Write a function that takes as input a character vector and returns a numeric vector with the numbers of characters
