setwd("D:/Kaggles/Springleaf")
library(readr)
library(caret)
library(ROCR)
library(h2o)

# read clean data and convert to numerical factors (might not be needed for h2o)
trainset <- read_csv("newtrain.csv")


for (i in 1:ncol(trainset)) { 
  if (class(trainset[, i]) == "character") { 
    tmp <- as.numeric(as.factor(c(trainset[,i])))
    trainset[,i]<- head(tmp, nrow(trainset))
    # simplify this
  }
}
trainset[is.na(trainset)] <- -9999

# alternate method
for (f in feature.names) {
  if (class(train[[f]])=="character") {
    levels <- unique(c(train[[f]], test[[f]]))
    train[[f]] <- as.integer(factor(train[[f]], levels=levels))
    test[[f]]  <- as.integer(factor(test[[f]],  levels=levels))
  }
}




testset[is.na(testset)] <- -9999
testids <- testset$ID
testset <- testset[, -1]    ## see how the web interfc traats this

rm(tmp)

localh2o <- h2o.init(nthreads=-1, max_mem_size = "6G")
train.hex <- as.h2o(trainset, destination_frame = "trainset.hex")
train.hex[, "target"] <- as.factor(train.hex[, "target"])
test.hex <- as.h2o(testset, destination_frame = "testset.hex")

# go to web interface localhost:54321
# build gbm 
# predict onto the test set
# pull back into R

preds <- read_csv("preds.csv")
submission <- data.frame(id=testids)
submission$target <- preds$Y
write_csv(submission, "gbmh2ogaussian.csv")
