
setDF(train)
train$TripType <- as.factor(train$TripType)
table(train$TripType)

p = 1/2  # 1/3, 1/4

val <- data.frame()

for(i in levels(train$TripType)) {
  dsub <- subset(train, train$TripType == i)
  B = ceiling(nrow(dsub) * p)
  dsub <- dsub[sample(1:nrow(dsub), B), ]
  val <- rbind(val, dsub) 
}



or



# create single Valset/holdout 
library(caret)
trainindex <- createDataPartition(as.factor(train[, "target"]), p=.9, list=FALSE, times=1)
val <- train[-trainindex, ]
train <- train[trainindex, ]