source("MySQLConnection.R") # connection is on ch
library(gregmisc)
library(foreach)
# ---------------------- GETTING DATA -----------------
ta <- dbGetQuery(ch, "SELECT one, two, three, four, five FROM TArestaurantDistribution;")
yelp <- dbGetQuery(ch, "SELECT one, two, three, four, five FROM YelpDistribution;")
ot <- 

tasimplified <- dbGetQuery(ch, "SELECT one, two, four, five FROM TArestaurantDistribution;")



# ---------------------- FUNCTIONS USED --------------
countDistributions <- function(x) { # x must be any of ta, yelp, ot
  distr = vector()
  for (i in 1:length(x$one)) {
    distr = append(distr, convertToNumber(getDistr(x[i,])))
  }
  distr <- factor(distr)
}





getDistr <- function(x) {
    require(gregmisc)
    if (mode(x) == "list") x = unlist(x)
    y <- sort(x, decreasing=T)
    if (any(duplicated(y))) {
      o <- sapply(unique(y), function(val) {
        m <- names(y[y==val])
        # just to make things quicker using length(m)
        if (length(m) <= 1) {
          return(m)
        }
        do.call(paste0, as.data.frame(permutations(length(m), length(m), m)))
      })
      out <- do.call(paste0, expand.grid(o))
    } else {
      out <- paste(names(y), collapse="")
    }
}

convertToNumber <- function(numStr) { # converts "one", "two" etc in "1", "2" and so on
  numStr = sub("one", "1", numStr, fixed=TRUE)
  numStr = sub("two", "2", numStr, fixed=TRUE)
  numStr = sub("three", "3", numStr, fixed=TRUE)
  numStr = sub("four", "4", numStr, fixed=TRUE)
  numStr = sub("five", "5", numStr, fixed=TRUE)
}