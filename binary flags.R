
# vectorized version?
events <- data.table("id" = seq(1:999999), "event_type" = rep(letters[1:20],100000))
head(events, 20)

setorder(events, event_type)
inds <- unique(events[, event_type])
events[, (inds) := 0]
sapply(inds, function(x) events[event_type == x, c(x) := 1])  # can also set c(x) to another column value

events[, event_type := NULL]
events <- events[, lapply(.SD, sum), by=id]
setorder(events, id)

head(events, 20)





# loop version to create binary flag vars  
for (f in names(train)) { 
  if (class(train[[f]]) == "character") {
    for(t in unique(c(train[, f], test[, f]))) {
      train[, paste0(f, t)] <- ifelse(train[, f] == t, 1, 0)
      test[, paste0(f, t)] <- ifelse(test[, f] == t, 1 ,0)
    }
    train[, f] <- NULL
    test[, f] <- NULL
  }              
}   
