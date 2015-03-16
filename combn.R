#Arjun Bharadwaj abharadwaj@ucdavis.edu
#Bijan Agahi bsagahi@ucdavis.edu
#Stefan Peterson stpeterson@ucdavis.edu

library('parallel')
library("snow")

#cls <- parallel::makePSOCKcluster(rep('localhost',10))

addComb <- function() {
  
}


test <- function(x, m) {
  stopifnot(length(m) == 1L, is.numeric(m))
  if(m < 0)
    stop("m < 0", domain = NA)
  if(is.numeric(x) && length(x) == 1L && x > 0 && trunc(x) == x)
    x <- seq_len(x)
  n <- length(x)
  if(n < m)
    stop("n < m", domain = NA)
  m <- as.integer(m)
  e <- 0
  h <- m
  a <- seq_len(m)
  len.r <- length(r <- x[a])
  count <- as.integer(round(choose(n,m)))
  out <- vector("list", count)
  out[[1L]] <- r
  if(m > 0) {
    i <- 2L
    nmmp1 <- n - m + 1L
    while(a[1L] != nmmp1) {
      if(e < n - h) {
        h <- 1L
        e <- a[m]
        j <- 1L
      }
      else {
        e <- a[m - h]
        h <- h + 1L
        j <- 1L:h
      }
      a[m - h + j] <- e + j
      out[[i]] <- r
      i <- i + 1L
    }
  }
out
}