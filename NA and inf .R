

# INF
for (j in 1:ncol(trainmain)) set(trainmain, which(is.infinite(trainmain[[j]])), j, NA)

# NA
for (j in seq_len(ncol(alldata))) set(alldata,which(is.na(alldata[[j]])),j,-1)

# NA
trainmain[is.na(trainmain)] <- -1

# Identify NAs
names(which(colSums(is.na(mymatrix))>0))