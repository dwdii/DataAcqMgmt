#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 6, 2014
#
# Description: Answers to IS607 Week 3 Quiz
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
dim(result6) # [1] 27  8

#### 7. ####
# Use the data sets from the previous question, but this time merge 
# them so that the rows from the price-data table all appear, even if 
# there is no match in the make-model data.
result7 <- merge(price.data, model.data, by="ModelNumber", all=TRUE)
dim(result7) # [1] 28  8

#### 8. ####
# Take your result from question 7 and subset it so that only the 2010 
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
# in each of the elements in the original vector
num.chars <- function(charVector)
{
  # Local Vars
  result <- NULL
  
  # check to make sure the input vector is actually a character vector.
  if(length(charVector) == 0 || !is.character(charVector[0]))
  {
    print("Specified vector is not a character vector.")
  } else
  {
    # Return
    return(nchar(charVector))
  }  
  
  return(result)
}
test1 <- c("one", "two", "three")
(res <- num.chars(test1)) # [1] 3 3 5

test2 <- c(1, 2, NA)
(res <- num.chars(test2)) # [1] "Specified vector is not a character vector."

#### 12. ####
# Write a function that takes two character vectors of equal length and 
# concatenates them element by element with a space as the separator. Have the 
# function die gracefully if the vectors are _not_ the same length.
concatenate <- function(charV1, charV2)
{
  # Local Vars
  l1 <- length(charV1)
  l2 <- length(charV2)
  result <- NULL
  
  if(l1 != l2)
  {
    print ("The input vectors must be of each length")
  } else
  {
    result <- mapply(paste, charV1, charV2, USE.NAMES=FALSE)
  }
  
  # Return
  return (result)
}
c1 <- c("one", "three", "five", "seven")
c2 <- c("two", "four", "six", "eight")
concatenate(c1, c2)
# [1] "one two"     "three four"  "five six"    "seven eight"

#### 13. ####
# Write a function that takes a character vector and returns the substring of 
# three characters that begins with the first vowel in the string. Have the 
# function handle gracefully substrings where this isn't possible.
fn13 <- function(charVector)
{
  # Locate the index of first vowel
  ndxVowel <- stringr::str_locate(charVector, pattern="[aeiou]")
  
  # Extract the vowel + 2 chars for total of three chars
  threeChars = stringr::str_sub(charVector, ndxVowel[,1], ndxVowel[,1] + 2)
  
  # Return
  return (threeChars)
}
cv13 <- c("alpha", "beta", "gamma")
(fn13(cv13))
[1] "alp" "eta" "amm"

#### 14. ####
# Suppose you have a data frame where one column gives the month (in numeric 
# format), the next gives the day, and the third column gives the year. Use 
# R to create such a data frame (by hand is fine) and then add a fourth column
# with the date in date format.
month <- c(1,2,3,4,5,6,7,8,9,10,11,12)
day <- c(30,28,26,25,22,30,19,2,4,2,6,7)
year <- c(1975,1982,1991,1993,2001,1995,1999,2003,2008,2011,2013,2005)
(theParts <- data.frame(month, day, year))
dateFormat <- function(df)
{
  strDate <- sprintf("%d-%d-%d", df$year, df$month, df$day)
  asDate <- as.Date(strDate, format="%Y-%m-%d")
  
  return(asDate)
}
(theDates <- plyr::ddply(theParts, .variables=c("month", "day", "year"), .fun=dateFormat))
#    month day year         V1
# 1      1  30 1975 1975-01-30
# 2      2  28 1982 1982-02-28
# 3      3  26 1991 1991-03-26
# 4      4  25 1993 1993-04-25
# 5      5  22 2001 2001-05-22
# 6      6  30 1995 1995-06-30
# 7      7  19 1999 1999-07-19
# 8      8   2 2003 2003-08-02
# 9      9   4 2008 2008-09-04
# 10    10   2 2011 2011-10-02
# 11    11   6 2013 2013-11-06
# 12    12   7 2005 2005-12-07

#### 15. ####
# Illustrate the code necessary to take a string of MM-DD-YYYY format and convert it to a date.
strDate15 <- "09-07-2014"
(theDate15 <- as.Date(strDate15, "%m-%d-%Y"))
# [1] "2014-09-07"

#### 16. ####
# Illustrate the code necessary to take a date and extract the month of the date
(theMonth16 <- format(Sys.Date(), "%m"))

#### 17. ####
# Create a sequence of all of the dates from January 1, 2005, to December 31, 2014.
numeric.days <- seq(0, (365 * 10) + 1)
head(theDates17 <- as.Date(numeric.days, "2005-01-01"))
# [1] "2005-01-01" "2005-01-02" "2005-01-03" "2005-01-04" "2005-01-05" "2005-01-06"

tail(theDates17)
# [1] "2014-12-26" "2014-12-27" "2014-12-28" "2014-12-29" "2014-12-30" "2014-12-31"
