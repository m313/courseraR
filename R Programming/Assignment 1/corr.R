corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations

    

    # initialize NA solution vector, to be truncated later.
    correlations <- rep(NA, length(332))
    
#     compl <- complete("specdata")
#     good.files <- compl$nobs>threshold
    
    ## loop over good files
    for (i in 1:332){
        fname <- sprintf("%03d.csv",i)
        data <- read.csv(file.path(directory, fname))
#         print(c(fname, sum(complete.cases(data))))
        if (sum(complete.cases(data)) > threshold){
            correlations[i] <- cor(data$sulfate, data$nitrate, use="pairwise.complete.obs")
        }
    }
    correlations[!is.na(correlations)]
}
