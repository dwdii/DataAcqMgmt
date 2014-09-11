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
  
  # How many of each?
  theCounts <- plyr::count(noNAs)
  
  fn.p.log2.p <- function(r)
  {
    p.i <- (r / length(noNAs))
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

  # Count all 
  print(a.counts <- plyr::count(a))
  
  # Create the partitions
  partitions <- split(d, a)
  
  # How many in each parition
  print(p.counts <- lapply(partitions, plyr::count))
  
  # Entropy for each partition
  print(Ed <- lapply(partitions, entropy))
  
  print(En.part <- data.frame(Ed))
  
  fn.njn <- function(r)
  {
    return (r$freq / sum(r$freq))
  }
  
  
  print(njn <- lapply(p.counts, fn.njn)) # [as.character(a.counts$x)]$freq / a.counts$freq))
  #print(njnEd <- lapply(Ed, njn))
}

# Load the test data
(pathToCsv <- file.path(getwd(), "Week3", "entropy-test-file.csv"))
head(testData <- read.table(file = pathToCsv, header = TRUE, sep = ","))

# Run through the hoops
entropy(testData$answer)

infogain(testData$answer, testData$attr1)
