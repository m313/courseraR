rankall <- function (outcome, num = "best") {
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
    
    ## For each state, find the hostpital of the given rank
    
    if (outcome=="heart attack") {index <- 11}
    if (outcome=="heart failure") {index <- 17}
    if (outcome=="pneumonia") {index <- 23}
    data[,index] <- as.numeric(data[,index])
    
    states <- sort(unique(data[,7]))  
    
    # create dataframe of 54x2
    df <- data.frame(hospital=character(), state=character(), 
                     stringsAsFactors=FALSE)
    
    c <- 0
    for (s in states){
        c <- c+1
        
        ## copy all my previous code. use s. save to dataframe[count]
        # select data with correct state and where rate values exist (locical 4706)
        good_state <- data[,7]==s
        good_rate <- !is.na(data[,index])
        selected <- good_state & good_rate
        
        # extract names and mortality of selected cases
        names <- data[selected,2]
        mortality <- data[selected,index] 
        
        # create ranking by mortality (and alphabetical order)
        rank <- order(mortality, names)
        
        # check num argument:
        if (!is.numeric(num)){
            if (num=="best"){
                df[c,2] <- s
                df[c,1] <- names[rank[1]]
            }
            if (num=="worst"){
                df[c,2] <- s
                df[c,1] <- names[rank[length(rank)]]
            }
        }
        
        if (is.numeric(num)){
        
            if (num > length(rank)){
                df[c,2] <- s
                df[c,1] <- NA
            }
            else {
                df[c,2] <- s
                df[c,1] <- names[rank[num]]
            }
        }        
    }
    
    ## Return a  data fram with the hospial names and the (abbreviated) state 
    ## names
    df
    
}