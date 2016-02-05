colnames(mymatrix)[apply(is.na(mymatrix), 2, any)]

colnames(mymatrix)[colSums(is.na(mymatrix)) > 0]

names(which(colSums(is.na(mymatrix))>0))