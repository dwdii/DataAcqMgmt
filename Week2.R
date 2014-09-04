#
#     Author: Daniel Dittenhafer
#
#     Created: Aug 31, 2014
#
# Description: Answers to Week 2 Assignment - Exercises
#

# 1.a. Assign the five individuals to a vector called queue
(queue <- c("James", "Mary", "Steve", "Alex", "Patricia"))

# 1.b. Update the queue for the arrival of a new patron named Harold.
(queue <- c(queue, "Harold"))

# 1.c. Update the queue to reflect the fact that James has finished checking out.
(queue <- queue[2:length(queue)])

# 1.d. Update the queue to reflect the fact that Patricia has talked her way 
#      in front of Steve with just one item.
(queue <- queue[c(1, 4, 2, 3, 5)])

# 1.e. Update the queue to reflect that fact that Harold has grown impatient
#      and left.
(queue <- queue[1:length(queue) - 1])

# 1.f. Update the queue to reflect the fact that Alex has grown impatient and left.
#      Do this as if  you do not know what slot Alex currently occupies by number.
#      http://stat.ethz.ch/R-manual/R-patched/library/base/html/subset.html
notAlex <- queue != "Alex"
(queue <- subset(queue, notAlex))

# 1.g. Identify the position of Patricia in the queue
#      http://www.r-tutor.com/r-introduction/vector/named-vector-members
ndx <- c(1:length(queue))
names(ndx) <- queue
(ndx["Patricia"])

# 1.h. Count the number of people in the queue
(length(queue))

######
# 2. Modify your answer to quiz exercise 21 so that when you implement the 
#    quadratic equation, meaningful outp is given whether there are one, two, or no solutons.
a <- 2
b <- 9 # b^2 = 81
c <- 4

(discrimant <- b^2 - 4 * a * c)
if(discrimant < 0)
{
  # No real solutions
  print("No real solutions")
  x <- NA
} else if(discrimant == 0)
{
  # Only one solution
  b2v <- 0
} else
{
  # Multi-real solution. Consider plus/minus
  (b2 <- sqrt(discrimant)) # 81 - 4 * 2 * 4
  b2v <- c(b2, -1 * b2) # plus/minus
}

if(discrimant >= 0)
{
  x <- (-1 * b  + b2v) / (2 * a)
}

# Show final result
x

############
# 3. Use R to determine how many numbers from 1 to 1000 are not divisible by any of 3,7, and 11
#    http://markmail.org/message/dfmmyfjhsztqiake
ds <- c(1:1000)
three <- ds %% 3
seven <- ds %% 7
eleven <- ds %% 11

threeBit <- three != 0
sevenBit <- seven != 0
elevenBit <- eleven != 0

notDivisible <- ifelse(threeBit == 1 & sevenBit == 1 & elevenBit == 1, TRUE, FALSE)
(countNotDivByAny <- sum(notDivisible)) # Ans: 520

############
# 4. Write R code that takes three input constants f, g, and h and determinues 
#    whether they form a Pythagorean Triple (such that the square of the largest
#    is equal to the sum of the squares of the other two constants)
#    http://stat.ethz.ch/R-manual/R-patched/library/base/html/sort.html
f <- 8
g <- 6
h <- 10
triple <- c(f, g, h)
triple <- sort(triple, decreasing = TRUE)
(tripleSquared <- triple^2)
(isPythagTriple <- tripleSquared[1] == (tripleSquared[2] + tripleSquared[3]))
