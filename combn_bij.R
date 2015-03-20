library("parallel")
library("snow")

#cls <- parallel::makePSOCKcluster(rep('localhost',4))

combn_R <- function(x,m,FUN=NULL,simplify=0){
  size <- choose(x,m)
  values <- seq_len(x)
  allCombs <- c() #initialize allCombs
  allCombinations <- list()
  findEntriesPerLevel <- function(x,m){
    array <- array(rep(0,(x-m+1)))
    array[1] <- 0
    for(i in 2:(x-m+1)){
      array[i] <- array[i-1]+(choose(x-i+1,m-1)*m)
      #print(array[i])
    }
    array
  }
  addComb <- function(v, v2){
    v[[length(v)+1]] <- v2
  }
  findCombs <- function(offset, k, v, combination){
    if(k==0){
      addComb(v, combination)
      0
    }
    for(i in offset:length(values)-k){
      combination[length(combination)+1] <- values[i]
      findCombs(i+1,k-1,v,combination)
      combination <- combination[-(length(combination))]
    }
  }
  numEntriesPerLevel <- findEntriesPerLevel(x,m)
  print(numEntriesPerLevel)
  #print(numEntriesPerLevel)
  combination <- c() #initialize combination
  for(i in 1:(x-m+1)){
    levelCombinations <- list()
    combination[length(combination)+1] <- i
    findCombs(i, m-1, levelCombinations, combination)
    combination <- combination[-(length(combination))]
  }
}

combn_R(5,3)
