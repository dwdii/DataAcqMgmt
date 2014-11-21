#
#     Creator: Daniel Dittenhafer
#
#     Created: Nov 21, 2014
#
# Description: Performance Test of R vs ...
#
require(microbenchmark)
require(doParallel)

registerDoParallel(cores=3) 

foreach(i=1:3) %dopar% sqrt(i)
