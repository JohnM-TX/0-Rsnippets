# Get dims
dim(trainData)


# count NAs

#just out of curiosity, how much data is missing?
#create anonymous function that counts number of NAs in each column
totalna <- sapply(trainData, function(x) sum(is.na(x)))
totalna



#percentages of missing data in each column
percent_missing <- totalna/dim(trainData)[1]
percent_missing



#finding the number of unique values for each column using anonymous function
#this will allow me to make assumptions on which ones are categorical 
#(out of the ones that haven't already been identified as such by being string-type)
numlevels <- sapply(trainData, function(x) length(unique(x)))
numlevels



