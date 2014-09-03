#
#     Author: Daniel Dittenhafer
#
#     Created: Aug 31, 2014
#
# Description: Answers to Week 2 Quiz
#

# 1. Create a vector that contains 20 numbers.
myFirstVector <- c(2,4,4,6,8,9,10,12,13,13,15,16,18,19,20,21,21,24,25,26)
length(myFirstVector)  # = 20

# 2. Use R to convert the vector from question 1 into a character vector.
charVector <- as.character(myFirstVector)
charVector  # Show the resulting character vector.

# 3. Use R to convert the vector from question 1 into a vector of factors.
factorVector <- as.factor(myFirstVector)

# 4. Use R to show how many levels the vector in the previous question has.
length(levels(factorVector))  # = 17

# 5. Use R to create a vector that takes the vector from question 1 and 
#    performs on it the formula 3x^2 - 4x + 1
resultVec <- 3 * myFirstVector ^ 2 - 4 * myFirstVector + 1
resultVec 

# 6. Implement orgindary least-squares regression in matrix form...
(X <- matrix(c(1, 1, 1, 1, 1, 1, 1, 1,
               5, 4, 6, 2, 3, 2, 7, 8,
               8, 9, 4, 7, 4, 9, 6, 4), ncol = 3))

(y <- matrix(c(45.2,
              46.9,
              31.0,
              35.3,
              25.0,
              43.1,
              41.0,
              35.1), ncol = 1))

(B.hat <- solve( t(X) %*% X ) %*% t(X) %*% y  )  # solve takes the inverse

# 7. Create a named list...
(list7 <- list(MyFirstVector = myFirstVector, 
               TheFactorVector = factorVector, 
               ResultVector = resultVec))  # Showing the list after creation

# 8. Create a data frame with four columns...
charV <- c("Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet", 
           "Blue", "Red", "Yellow")
factorV <- as.factor(c("Labor", "Capital", "Tax", "Labor", "Capital", "Tax", 
                       "Labor", "Capital", "Tax", "Labor"))
numV <- c(3, 1, 4, 1, 5, 9, 2, 6, 5, 3)
dateV <- as.Date(c('2014-01-01', '2014-01-02', '2014-01-03', '2014-01-04', 
                   '2014-01-05', '2014-01-06', '2014-01-07', '2014-01-08', 
                   '2014-01-09', '2014-01-10'))

theDF <- data.frame(charV, factorV, numV, dateV)
theDF # Show the data frame

# 9. Illustrate how to add a row with a value from the factor column that 
#    isn't already in the list of levels.
newRow <- c("Red", "Interest", 5, "2014-01-11")  # Allocate new row vector
levels(theDF$factorV) <- c(levels(theDF$factorV), "Interest")  # Add new level 
theDF <- rbind(theDF, newRow) # Append new row


# 10. Show the code that would read in a CSV file called tempuratures.csv
#     from the current working directory.
workingDir <- getwd()
pathToCsv <- paste(c(workingDir, "/temperatures.csv"), collapse="")
(tempsDF <- read.table(file = pathToCsv, header = TRUE, sep = ","))

# 11. Show the code that would read in a TSV file called measurements.txt 
#     from a directory other than the working directory on your local marchine.
pathToTsv <- "C:/SourceCode/R/DataAcqMgmt/measurements.txt"
(measureDF <- read.table(file = pathToTsv, header = TRUE, sep = "\t"))

# 12. Show the code that will read in a delimited file with a pipe separator
#     (the "|" symbol) from a website location.
pathToHttpPipe <- "https://raw.githubusercontent.com/dwdii/DataAcqMgmt/master/pipeSeparatedData.txt"
(measureDF <- read.table(file = pathToHttpPipe, header = TRUE, sep = "|"))

# 13. Write a loop that calculates 12-factorial
factorial <- 12
result = 1
for(i in 1 : factorial)
{
  result <- result * i
}

# 14. Use a loop to calculate the final balance, rounded to the nearest cent...
# **  Assuming the interest rate is a monthly rate (rather than an annual rate) **
years = 6
months= years * 12
currentBalance = 1500
rate = 0.0324
for(m in 1 : months)
{
  currentBalance <- currentBalance * (1 + rate)
}
round(currentBalance, 2)

# 15. Create a numeric vector of length 20 and then write code to calulate the 
#     sum of every third element.
#     3rd, 6th, 9th, ... 18th
numV2 <- c(2, 7, 1, 8, 2, 8, 1, 8, 2, 8, 4, 5, 9, 0, 4, 5, 2, 3, 5, 3)
nthItem <- 3
sumV2 <- 0
for(i in seq(nthItem, length(numV2), by=nthItem))
{
  #print(i)
  #print(numV2[i])
  sumV2 <- sumV2 + numV2[i]
}
sumV2 # 1 + 8 + 2 + 5 + 4 + 3 = 23

# 16. Use a for loop to calculate summation x^i where x = 2... 
sum16 <- 0
x <- 2
for(i in 1 : 10)
{
  #print(pow2 <- x^i)
  sum16 <- sum16 + pow2
}
sum16

# 17. Use a while look to accomplish the same task as in the previous exercise
sum17 <- 0
x <- 2
i <- 1
while(i <= 10)
{
  pow2 <- x^i
  sum17 <- sum17 + pow2
  i <- i + 1
}
sum17

# 18. Solve the problem from the previous two exercises without using a loop
x <- 2
expVal <- c(1,2,3,4,5,6,7,8,9,10)
powResult <- x^expVal
sum18 <- sum(powResult)

# 19. Show how to create a numeric vector that contains the sequence from 
#     20 to 50 by 5
numSeq <- seq(20, 50, by=5)

# 20. Show how to create a character vector of length 10 with the same word, 
#     "example", ten times
exampleV <- rep("example", 10)

# 21. Show how to take a trio of input numbers a, b, c and implement the 
#     quadratic equation
a <- 2
b <- 9 # b^2 = 81
c <- 4

(b2 <- sqrt(b^2 - 4 * a * c)) # 81 - 4 * 2 * 4

b2v <- c(b2, -1 * b2) # plus/minus

(x <- (-1 * b  + b2v) / (2 * a))
