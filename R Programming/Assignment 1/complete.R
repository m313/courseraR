complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    
    # initialize data frame
    df <- data.frame("id"=id, "nobs"= numeric(length(id)))
    
    ## loop over files
    for (i in id){
        fname <- sprintf("%03d.csv",i)
        data <- read.csv(file.path(directory, fname))
        df$nobs[df$id==i] <- sum(complete.cases(data))
    }
    df
}
