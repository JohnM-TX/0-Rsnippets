
for (j in 1:ncol(trainmain)) set(trainmain, which(is.infinite(trainmain[[j]])), j, NA)
trainmain[is.na(trainmain)] <- 0