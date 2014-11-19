#
#     Creator: Daniel Dittenhafer
#
#     Created: Nov 18, 2014
#
# Description: Performance Test of R executing mean of 100 Million numbers
#
require(microbenchmark)

mean <- function(a)
{
  # Local Vars
  sum <- 0
  count <- length(a)
  
  for ( x in a)
  {
    sum <- sum + x
  }
  
  m <- sum / count
  
  # Return
  return(m)  
}

a <- sample(1:20, 100000000, replace=TRUE)
results <- microbenchmark::microbenchmark(mean(a), times=1)
print(results)