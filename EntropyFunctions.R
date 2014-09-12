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
infogain <- function(d, a, show.details=FALSE)
{
  # get the unpartitioned E
  rawE <- entropy(d)

  # How many items in each parition
  a.counts <- plyr::count(a)
  
  # Create the partitions
  partitions <- split(d, a)
  
  # Entropy for each partition
  Ed <- lapply(partitions, entropy)
  
  # "Entropy by partition as data frame"
  En.part <- data.frame(partition=names(Ed), entropy=unlist(Ed))

  # Calculate the weights
  njn <- a.counts$freq / sum(a.counts$freq)
  
  # Convert to data frame
  njn.df <- data.frame(partition=a.counts$x, 
                             weight=unlist(njn))
  
  # Join for easier calculation
  njnEd <- merge(njn.df, En.part, by="partition")
  
  # Does the caller want us to print details of the partitions?
  if(show.details)
  {
    print(njnEd)  
  }
  

  # Calculate the information gain
  theInfoGain <- rawE - sum(njnEd$weight * njnEd$entropy)
  
  # Return 
  return(theInfoGain)
}

#### 3. ####
decide <- function(d, n)
{
  result <- list(max=NA, gains=NA)

  # Get a list of just the attribute columns
  theAttrs <- subset(d, select=-n)
  
  # Helper function
  applyInfoGain <- function(r)
  {
    return (infogain(d[,n], r, show.details=FALSE))
  }

  # Calculate and record the info gains
  o <- lapply(theAttrs, applyInfoGain)
  result$gains <- unlist(o)
  
  maxInfoGain <- result$gains[result$gains == max(result$gains)]
  result$max <- which(names(result$gains)==names(maxInfoGain))
  
  return(result)
}

# Load the test data
(pathToCsv <- file.path(getwd(), "Week3", "entropy-test-file.csv"))
head(testData <- read.table(file = pathToCsv, header = TRUE, sep = ","))

# Run through the hoops
#
# Raw Entropy
entropy(testData$answer)
# [1] 0.9832692

# Info gain from attribute 1
infogain(testData$answer, testData$attr1, show.details=FALSE)
# [1] 2.411565e-05

# Info gain from attribute 2
infogain(testData$answer, testData$attr2, show.details=FALSE)
# [1] 0.2599038

# Info gain from attribute 3
infogain(testData$answer, testData$attr3, show.details=FALSE)
# [1] 0.002432707

# Run the decision function to determine the best partitioning for the data.
decide(testData, 4)
# $max
# [1] 2
# 
# $gains
# attr1        attr2        attr3 
# 2.411565e-05 2.599038e-01 2.432707e-03 