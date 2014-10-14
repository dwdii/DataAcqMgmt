# 
# Author: Daniel Dittenhafer
#
# Created: Oct 13, 2014
#
# Description: Answers to Week 8 Data Science Context
#
require (ggplot2)

seats <- seq(1,12,1)
ids <- factor(seats)
ids

values <- data.frame(id=ids, value = rep(seats, each=1))
values

rep(ids, each=4)

row1X <- c(0.6,0.6,1.4,1.4)
row2X <- c(1.6,1.6,2.4,2.4)
allRowsX <- c(rep(row1X, times=6), rep(row2X, times=6))
allRowsX

# Define the Y coordinates for the seats
rowY <- c(0.5,1.4,1.4,0.5, 1.5,2.4,2.4,1.5, 2.5,3.4,3.4,2.5, 3.5,4.4,4.4,3.5, 4.5,5.4,5.4,4.5, 5.5,6.4,6.4,5.5)

# Create vector row all rows by multiplying the Y coords.
allRowsY <- c(rep(rowY, times=2))
allRowsY

# Full seat row positions
positions <- data.frame(id=rep(ids, each=4), 
                        x=allRowsX,
                        y=allRowsY)

# merge the values with the positions by id
data <- merge(values, positions, by=c("id"))
data

# reproducible data structure
dput(data)

someData <- structure(list(id = structure(c(1L, 1L, 1L, 1L, 10L, 10L, 10L, 
10L, 11L, 11L, 11L, 11L, 12L, 12L, 12L, 12L, 2L, 2L, 2L, 2L, 
3L, 3L, 3L, 3L, 4L, 4L, 4L, 4L, 5L, 5L, 5L, 5L, 6L, 6L, 6L, 6L, 
7L, 7L, 7L, 7L, 8L, 8L, 8L, 8L, 9L, 9L, 9L, 9L), .Label = c("1", 
"2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"), class = "factor"), 
value = c(1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 12, 
12, 12, 12, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 
5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9), x = c(0.6, 
0.6, 1.4, 1.4, 1.6, 1.6, 2.4, 2.4, 1.6, 1.6, 2.4, 2.4, 1.6, 
1.6, 2.4, 2.4, 0.6, 0.6, 1.4, 1.4, 0.6, 0.6, 1.4, 1.4, 0.6, 
0.6, 1.4, 1.4, 0.6, 0.6, 1.4, 1.4, 0.6, 0.6, 1.4, 1.4, 1.6, 
1.6, 2.4, 2.4, 1.6, 1.6, 2.4, 2.4, 1.6, 1.6, 2.4, 2.4), y = c(0.5, 
1.4, 1.4, 0.5, 3.5, 4.4, 4.4, 3.5, 4.5, 5.4, 5.4, 4.5, 5.5, 
6.4, 6.4, 5.5, 1.5, 2.4, 2.4, 1.5, 2.5, 3.4, 3.4, 2.5, 3.5, 
4.4, 4.4, 3.5, 4.5, 5.4, 5.4, 4.5, 5.5, 6.4, 6.4, 5.5, 0.5, 
1.4, 1.4, 0.5, 1.5, 2.4, 2.4, 1.5, 2.5, 3.4, 3.4, 2.5)), .Names = c("id", 
"value", "x", "y"), row.names = c(NA, -48L), class = "data.frame")

g1 <- ggplot(data=someData, aes(x=x, y=y))
g1 <- g1 + geom_polygon(aes(fill=value, group=id))
g1 <- g1 + annotate("text", x = c(1,1,1,1,1,1), y = c(1,2,3,4,5,6), label = c("A", "B", "C", "D", "E", "F"), colour="white", size=14)
g1

sessionInfo()