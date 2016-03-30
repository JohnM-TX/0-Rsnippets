
# create single Valset/holdout 
library(caret)
trainindex <- createDataPartition(as.factor(train[, "target"]), p=.9, list=FALSE, times=1)
val <- train[-trainindex, ]
train <- train[trainindex, ]