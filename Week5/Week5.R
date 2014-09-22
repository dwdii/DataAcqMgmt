#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 22, 2014
#
# Description: Answers to IS607 Week 5 Assignment
#

#### 1. ####
# Write down 3 questions that you might want to answer based on this data.
#
# 1. What proportion of the respondents in each city voted yes vs. no?
# 2. What proportion of the respondents in each age group voted yes vs. no?
# 3. How many total respondents were there?

#### 2. ####
# Create an R data frame with 2 observations to store this data in its current 
# "messy" state. Use whatever method you want to re-create and/or load the data.
#
# Define the raw data columns
response.types <- c('Yes', 'No')
edinburgh.1624 <- c(80100, 35900)
edinburgh.25 <- c(143000, 214800)
glasgow.1624 <- c(99400, 150400)
glasgow.25 <- c(43000, 207000)

# Reconstruct the messy data
messy <- data.frame(response.types, 
                    edinburgh.1624, 
                    edinburgh.25, 
                    glasgow.1624, 
                    glasgow.25)

# Show me.
head(messy)

#### 3. ####
# Use the functionality in the tidyr package to convert the data frame to be 
# "tidy data."
#
