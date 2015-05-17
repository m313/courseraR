rankhospital <- function(state, outcome, num = "best") {
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
    
    ## Return hospital name in that state with the given rank 30-day death rate
    
    if (outcome=="heart attack") {index <- 11}
    if (outcome=="heart failure") {index <- 17}
    if (outcome=="pneumonia") {index <- 23}
    data[,index] <- as.numeric(data[,index])
    
    # select data with correct state and where rate values exist (locical 4706)
    good_state <- data[,7]==state
    good_rate <- !is.na(data[,index])
    selected <- good_state & good_rate
    
    # extract names and mortality of selected cases
    names <- data[selected,2]
    mortality <- data[selected,index] 
    
    # create ranking by mortality (and alphabetical order)
    rank <- order(mortality, names)
    
    # check num argument:
    if (num=="best"){
        return(names[rank[1]])
    }
    if (num=="worst"){
        return(names[rank[length(rank)]])
    }
    if (num > length(rank)){
        return(NA)
    }
    else {
        return(names[rank[num]])
    }
    
}