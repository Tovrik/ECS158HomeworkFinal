library("parallel")
library("snow")

combn_R <- function(x,m,FUN=NULL,simplify=0){
  size <- choose(x,m)
  values <- seq_len(x)
  allCombs <- c() #initialize allCombs
  numEntriesPerLevel <- function(x,m){
    array[0] <- 0
    for(i in 1:(x-m+1)){
      array[i] = array[i-1]+(choose(x-i,m-1)*m)
    }
    array
  }
  #print(numEntriesPerLevel)
  combination <- c() #initialize combination
  for(i in 1:(x-m+1)){
    combination <- append(combination,i)
  }
}