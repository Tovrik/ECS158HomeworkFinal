#Import the existing libraries(mainly snow nad parallel)
#library("snow")

combn_R <- function(x, m, FUN = NULL, simplify = TRUE) {
  # Determine the total size
  size <- choose(x, m)
  # Generate from 1 to n range
  values <- seq_len(x)
  # All combinations
  allCombs <- vector(mode = "numeric", length = size * m)
  # Number of entries Per Level
  numEntriesPerLevel <- vector(mode = "numeric", length = x - m + 1)
  
  
}

combn_R(5, 3)
