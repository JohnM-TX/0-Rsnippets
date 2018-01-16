
allmxs <- lapply(1:17, function(x) eval(parse(text=paste("mxtrain", x, sep=""))))
mxtrain <- do.call(rbind, allmxs)
