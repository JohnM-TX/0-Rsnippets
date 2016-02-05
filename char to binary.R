
# create binary flag vars  
for (f in names(train)) { 
  if (class(train[[f]])=="character") {
    for(t in unique(c(train[, f], test[, f]))) {
      train[paste(f,t,sep="")] <- ifelse(train[, f]==t,1,0)
      test[paste(f,t,sep="")] <- ifelse(test[, f]==t,1,0)
    }
    train[, f] <- NULL
    test[, f] <- NULL
  }              
}   
