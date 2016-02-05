numtrain <-  train[, .SD, .SDcols = sapply(train, is.numeric)]
numtrain <- numtrain[, -2, with=FALSE]