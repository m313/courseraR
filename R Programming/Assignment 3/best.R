best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
    
    ## Check that state and outcome are valid
    if (!sum(data[,7]==state)){
        stop("invalid state")
    }
    if (!( (outcome=="heart attack") | 
               (outcome=="heart failure") | 
               (outcome=="pneumonia"))) {
        stop("invalid outcome")
    }
    
    ## Return hospital name in that state with lowest 30-day death rate    
    if (outcome=="heart attack") {index <- 11}
    if (outcome=="heart failure") {index <- 17}
    if (outcome=="pneumonia") {index <- 23}
    data[,index] <- as.numeric(data[,index])
    minval <- min(data[data[,7]==state, index], na.rm=TRUE)
    
    good_state <- data[,7]==state
    good_val <- data[,index]==minval
    good_val[is.na(good_val)] <- FALSE  # set NAs to FALSE
    
    names <- data[good_state & good_val,2]
    
    min(names) # in case of multiple names, take the first in alphabetical order
}


