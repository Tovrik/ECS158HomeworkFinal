#Arjun Bharadwaj abharadwaj@ucdavis.edu
#Bijan Agahi bsagahi@ucdavis.edu
#Stefan Peterson stpeterson@ucdavis.edu

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
  # All permutations
  allCombinations <- list()
  # Setup the initial stuff
  findEntriesPerLevel <- function() {
    # Indices in R start at 1
    numEntriesPerLevel[1] <- 0
    for(i in 2:(x - m + 1)) {
      numEntriesPerLevel[i] <- numEntriesPerLevel[i - 1] + (choose(x - i + 1, m - 1) * m)
    }
    numEntriesPerLevel
  }

  push_back <- function(combination, value) {
    combination[length(combination)+1] <- value
  }

  pop_back <- function(combination) {
    combination <- combination[-(length(combination))]
  }

  # # Assume v is a list since we are pushing to a 2d vector
  # addComb <- function(v, v2) {
  #   v[[length(v) + 1]] <- v2
  # }
  position <- 1

  findCombs <- function(offset, k, v, combination) {
    #position <- position + 1
    if(k == 0) {
      allCombinations[[position]] <<- combination
      position <<- position + 1
      #v <- append(v, combination)
      #print(combination)
      #print("reaching 0")
      #print(allCombinations)
      return(0)
    }
    for(i in offset:((length(values) - k)+1) ) {
      combination <- c(combination, values[i])
      findCombs(i + 1, k - 1, v, combination)
      combination <- pop_back(combination)
    }
  }

  numEntriesPerLevel <- findEntriesPerLevel()
  #print(numEntriesPerLevel)

  # This is the main loop
  for(i in 1:(x - m + 1)) {
    # List of vectors. In C++, 2d Vector
    levelCombinations <- list()
    # Our local 1d array
    combination <- c()
    #i <- 1
    combination <- c(combination, i)
    # Call to recursive function
    findCombs(i + 1, m - 1, levelCombinations, combination)
    #print(combination)
    combination <- pop_back(combination)
    #print(paste("Now Popping back\n"))
  }
  print(allCombinations)

}

# Test code
x <- 5
m <- 3
combn_R(x, m)
