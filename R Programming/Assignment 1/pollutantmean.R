pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    #### HERE I TAKE THE MEAN OF EACH FILE AND RETURN IT AS ONE
    #### ELEMENT OF A VECTOR. INSTEAD, I SHOULD CONCATENATE DATA 
    #### FROM ALL FILES (maybe only good data) AND THEN TAKE THE 
    #### MEAN ACROSS THE WHOLE POPULATION!
    
    ## initialize result vector
    #     means <- numeric(length(id))
    #     
    #     expeceted_samples <- 100 # expecting 100 good samples per file.
    #     data_combined <- numeric(length(id)*expected_samples)
    
    data_combined <- numeric(1) # poor man's initialization 
    counter <- 0
    
    
    
    ## loop over files
    for (i in seq_along(id)){
        fname <- sprintf("%03d.csv",id[i])
        data <- read.csv(file.path(directory, fname))
        good <- !is.na(data[, pollutant])
        good_data <- data[, pollutant][good]    
        print(c(fname, i, counter, length(good_data)))
        if (length(good_data) > 0) {
            data_combined[(counter+1):(counter+length(good_data))] <- good_data
            counter <- counter +length(good_data)
        } else {
            print("skipping a line")
        }
    }
    mean(data_combined)    
}
