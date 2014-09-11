#
#     Author: Daniel Dittenhafer
#
#     Created: Sept 10, 2014
#
# Description: Entropy and Information Gain Project
#

#### 1. ####
entropy <- function(d)
{
  # Local Vars
  E <- NA
  
  # Eliminate missing values
  noNAs <- subset(d, !is.na(d))
  
  # Convert to factor to give us categorical concept  
  asFactor <- as.factor(noNAs)
  
  # How many of each?
  theCounts <- plyr::count(asFactor)
  
  fn.p.log2.p <- function(r)
  {
    p.i <- (r / length(asFactor))
    return (p.i * log2(p.i))
  }
  
  # Entropy
  plog2p <- sapply(theCounts$freq,  fn.p.log2.p)
  E <- -1 * sum(plog2p)
  
  # Return
  return (E)
}

#### 2. ####
infogain <- function(d, a)
{
  # get the unpartitioned E
  rawE <- entropy(d)
  
  a.fact <- as.factor(a)
  print(a.counts <- plyr::count(a.fact))
  
  
}

# Load the test data
(pathToCsv <- file.path("C:/SourceCode/R/DataAcqMgmt/Week3", "entropy-test-file.csv"))
head(testData <- read.table(file = pathToCsv, header = TRUE, sep = ","))

# Run through the hoops
entropy(testData$answer)

infogain(testData$answer, testData$attr1)
