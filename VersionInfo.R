# 
# R version 3.1.1 and RStudio Version 0.98.1028
#
# PostgreSQL Version: *** TBD ***
#
# DMwR sales data set
# -------------------
# Load the Data Mining with R package
library("DMwR")

# How many data points per observation? Ans: 5
length(DMwR::sales) 

# How many observations? Ans: 401146
DMwR::sales[0]
