#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 22, 2014
#
# Description: Answers to IS607 Week 5 Assignment
#
require(tidyr)
require(plyr)
require(ggplot2)

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

# response.types edinburgh.1624 edinburgh.25 glasgow.1624 glasgow.25
# 1            Yes          80100       143000        99400      43000
# 2             No          35900       214800       150400     207000

#### 3. ####
# Use the functionality in the tidyr package to convert the data frame to be 
# "tidy data."
#
tidyData <-gather(messy, city.agerange, responses, edinburgh.1624:glasgow.25)
tidyData <- separate(tidyData, city.agerange, c("city", "agerange"), convert=FALSE)
tidyData <- extract(tidyData, agerange, c("lower", "upper"), regex="^(\\d{2})(\\d{2})?", convert=TRUE)

# Show me.
head(tidyData, n=10)
summary(tidyData)

#   response.types      city lower upper responses
# 1            Yes edinburgh    16    24     80100
# 2             No edinburgh    16    24     35900
# 3            Yes edinburgh    25          143000
# 4             No edinburgh    25          214800
# 5            Yes   glasgow    16    24     99400
# 6             No   glasgow    16    24    150400
# 7            Yes   glasgow    25           43000
# 8             No   glasgow    25          207000

#### 4. ####
# Use the functionality in the plyr package to answer the questions that you asked in step 1.
#
# 1. What proportion of the respondents in each city voted yes vs. no?
#
#        city response.types proportion
# 1 edinburgh             No  0.5291262
# 2 edinburgh            Yes  0.4708738
# 3   glasgow             No  0.7150860
# 4   glasgow            Yes  0.2849140
sumCity <- plyr::ddply(tidyData, "city", plyr::summarize, total = sum(responses), .inform=TRUE)
sumCity

#        city  total
# 1 edinburgh 473800
# 2   glasgow 499800

sumYesNoCity <- plyr::ddply(tidyData, c("city", "response.types"), plyr::summarize, sum = sum(responses), .inform=TRUE)
sumYesNoCity

#        city response.types    sum
# 1 edinburgh             No 250700
# 2 edinburgh            Yes 223100
# 3   glasgow             No 357400
# 4   glasgow            Yes 142400

sumYesNoCityTotal <- plyr::join(sumCity, sumYesNoCity, by="city")
sumYesNoCityTotal

#       city   total response.types    sum
# 1 edinburgh 473800             No 250700
# 2 edinburgh 473800            Yes 223100
# 3   glasgow 499800             No 357400
# 4   glasgow 499800            Yes 142400

cityProportionYesNo <- plyr::ddply(sumYesNoCityTotal, c("city", "response.types"), plyr::summarize, proportion = sum / total)
cityProportionYesNo

# Visualize
g1 <- ggplot(data=cityProportionYesNo, aes(x=response.types, y=proportion))
g1 <- g1 + facet_wrap(~ city)
g1 <- g1 + geom_bar(stat="identity")
g1 <- g1 + labs(title="Proportion Who Preferred Cullen Skink over Partan Bree By City", x="Preferred Cullen Skink over Partan Bree", y="Proportion")
g1


# 2. What proportion of the respondents in each age group voted yes vs. no?
# 
# lower upper response.types proportion
# 1    16    24             No  0.5092947
# 2    16    24            Yes  0.4907053
# 3    25    NA             No  0.6939783
# 4    25    NA            Yes  0.3060217

sumAge <- plyr::ddply(tidyData, c("lower", "upper"), plyr::summarize, total = sum(responses), .inform=TRUE)
sumAge

sumAgeYesNo <- plyr::ddply(tidyData, c("lower", "upper", "response.types"), plyr::summarize, sum = sum(responses), .inform=TRUE)
sumAgeYesNo

sumAgeJoin <- plyr::join(sumAge, sumAgeYesNo, by=c("lower", "upper"))
sumAgeJoin

ageProportionYesNo <- plyr::ddply(sumAgeJoin, c("lower", "upper", "response.types"), plyr::summarize, proportion = sum / total)
ageProportionYesNo

# Visualize
g2 <- ggplot(data=ageProportionYesNo, aes(x=response.types, y=proportion))
g2 <- g2 + facet_wrap(~ lower + upper)
g2 <- g2 + geom_bar(stat="identity")
g2 <- g2 + labs(title="Proportion Who Preferred Cullen Skink over Partan Bree By Age Group", x="Preferred Cullen Skink over Partan Bree", y="Proportion")
g2

# 3. How many total respondents were there?
#
# [1] 973600
totalRespondents <- sum(tidyData[, "responses"])
totalRespondents

#### 5. ####
# Having gone through the process, would you ask different questions and/or 
# change the way that you structured your data frame?
#
# * In Q4 I realized it might be better (faster) if city were a factor and added 
#   "convert=TRUE" to the separate call in Q3.
#
# * Likewise, to convert to numeric for lower/upper with regard to the extract call in Q3
# 
# * I think my original data frame structure worked well for this exercise, though the 
#   the data did require melting and tidying.
