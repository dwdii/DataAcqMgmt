# 
# R.version.string returns "R version 3.1.1 (2014-07-10)" for me.
R.version.string

# RStudio Version 0.98.1028

# PostgreSQL Version: 9.3.5.1 *** TBD ***

# DMwR sales data set
# -------------------
# Load the Data Mining with R package
library("DMwR")

# How many data points per observation? Ans: 5
length(DMwR::sales) 

# How many observations? Ans: 401146
DMwR::sales[0]

