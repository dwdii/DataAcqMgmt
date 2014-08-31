#
#     Creator: Daniel Dittenhafer
#
#     Created: Aug 31, 2014
#
# Description: Answers to Week 2 Quiz
#

# 1. Create a vector that contains 20 numbers.
myFirstVector <- c(2,4,4,6,8,9,10,12,13,13,15,16,18,19,20,21,21,24,25,26)
length(myFirstVector) # = 20

# 2. Use R to convert the vector from question 1 into a character vector.
charVector <- as.character(myFirstVector)
charVector # Show the resulting character vector.

# 3. Use R to convert the vector from question 1 into a vector of factors.
factorVector <- as.factor(myFirstVector)

# 4. Use R to show how many levels the vector in the previous question has.
length(levels(factorVector)) # = 17

# 5. Use R to create a vector that takes the vector from question 1 and 
#    performs on it the formula 3x^2 - 4x + 1
resultVec <- 3 * myFirstVector ^ 2 - 4 * myFirstVector + 1
resultVec 



