# find outliers and drop them
library(outliers)

j <- outlier(train, logical=TRUE)
count <- as.vector(1:133)
useup <- vector(mode="integer", length=length(count))
for (i in count) useup[i] <- train[which(j[, i] == TRUE), ID] 
warnings()
guestlist <- as.data.table(table(useup))
guestlist[, target := train[ID %in% useup, target]]
setorder(guestlist, -N)