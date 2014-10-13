# 
# Author: Daniel Dittenhafer
#
# Created: Oct 13, 2014
#
# Description: Answers to Week 8 Data Science Context
#
require (ggplot2)

ids <- factor(range(1,6,1))

aDataFrame = data.frame(ids=ids)

values <- data.frame(id=ids, value = rep(range(1,6,1), each=1))

positions <- data.frame(id=rep(ids, each=3), 
                        x=c(1,2,3,1,5,6,7,8),
                        
                        y=c(1,2,3,1,5,6,5,8))

data <- merge(values, positions, by=c("id"))

dput(aDataFrame)

g1 <- ggplot(data=data, aes(x=x, y=y))
g1 <- g1 + geom_polygon(aes(fill=value, group=id))
g1

sessionInfo()