# set dirs and load libraries
setwd("D:/Kaggles/Dato")
library(readr)
library(caret)
library(ROCR)

# read main training set
fulltrain <- read.csv(file="dtmtrain.csv", stringsAsFactors = FALSE)

# break out validation set and process for modeling 
trainindex <- createDataPartition(fulltrain[,"sponsored"], p=.8, list=FALSE, times=1)
trainset <- fulltrain[trainindex, ]
valset <- fulltrain[-trainindex, ]
mtrain <- trainset[, -c(1:2)]
dummytrain <- dummyVars(~ ., data=mtrain)
mtrain <- predict(dummytrain, newdata=mtrain)
mval <- valset[,-c(1,2)]
dummyval <- dummyVars(~ ., data=mval)
mval <- predict(dummyval, newdata=mval)


# run RF
library(randomForest)
trainfactor <- as.factor(trainset$sponsored)
rfmodel <- randomForest(mtrain, y=trainfactor, ntree=300, mtry=5, do.trace=TRUE)
predrf <- predict(rfmodel, mval, type="prob")
predrf <- as.numeric(predrf[,2])
# rffactors <- varImpPlot(rfmodel, scale=FALSE)


# validate models
validate <- valset
validation <- data.frame(file=validate$filename, rlabel=validate$sponsored)
validation$pred1 <- predxgb
validation$pred2 <- predrf
validation$pred <- predxgb+predrf          # change below if stacking

# do rank averages with existing set and with each other as needed

predsum1 <- prediction(validation$pred1, validation$rlabel)
predsum2 <- prediction(validation$pred2, validation$rlabel)
predsum <- prediction(validation$pred, validation$rlabel)
roccurve1 <- performance(predsum1, "tpr", "fpr")
roccurve2 <- performance(predsum2, "tpr", "fpr")
roccurve <- performance(predsum, "tpr", "fpr")
plot(roccurve1, col="red")
plot(roccurve2, col="blue", add=TRUE)
plot(roccurve, col="black", add=TRUE)
aucscore1 <- performance(predsum1, "auc")
aucscore2 <- performance(predsum2, "auc")
aucscoreall <- performance(predsum, "auc")
cat("XGB:", "\t", paste(aucscore1@y.values), "\n",
    "RF:", "\t", paste(aucscore2@y.values), "\n",
        "All:", "\t", paste(aucscoreall@y.values))




# # produce word lists for optimizing
# wordlist <- colnames(mval)
# write_csv(as.data.frame(wordlist), "wordlistfull.csv", col_names=FALSE)
# write.csv(rffactors, file="rffacs.csv", quote=FALSE, row.names=TRUE)
# write.csv(xgbfactors, file="xgbfacs.csv", quote=FALSE, row.names = FALSE)

source("test12.R")

# Run the TEST SET
test <- read_csv(file="dtmtest.csv")
mtest <- test[,-c(1)]
dummytest <- dummyVars(~ ., data=mtest)
mtest <- predict(dummytest, newdata=mtest)

# Predict values for the test set
submission <- data.frame(file=test$filename)
pred1t <- predict(xgbmodel, mtest)
pred2t <- predict(rfmodel, mtest, type="prob")
pred2t <- as.numeric(pred2t[,2])
submission$sponsored <- pred1t
submission$rf <- pred2t
write_csv(submission, "xgbblahhh.csv")



