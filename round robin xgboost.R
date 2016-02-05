library(data.table)
library(readr)
library(xgboost)                       

#get data
train <- fread("stackedtrainmastergrand.csv", header = T)
test <- fread("stackedtestmastergrand.csv", header = T)

setDF(train)
setDF(test)
#########################



# prep for xgboost
tlabels <- as.numeric(as.factor(train$TripType))-1
xgbtrain <- xgb.DMatrix(data.matrix(train[, -c(1:2)]), label=tlabels, missing=NA) 

xgbtest <- xgb.DMatrix(data.matrix(test[, -c(1:2)]), missing=NA)

# set params
numrounds=1200
set.seed(122)
param0 <- list(objective  = "multi:softprob"
               , eval_metric = "mlogloss"
               , num_class = 38
               , eta = 0.01
               , max_depth = 8 #
               , gamma = 0.3 # 0.6
               , min_child_weight = 5  # 2
               , max_delta_step = 0
               , subsample = 0.9
               , colsample_bytree = .7
)                                         

xgbfirst <- xgb.cv(data=xgbtrain
                   , params=param0
                   , nrounds=numrounds                                                           
                   , nfold=5
                   , verbose=1
                   , early.stop.round=NULL
) 





# train the model
watched <- list(train=xgbtrain)
xgbmod  <- xgb.train(data=xgbtrain 
                      , params = param0
                      , nrounds = numrounds
                      , verbose = 1
                      , watchlist = watched
                      , early.stop.round = NULL
)






# 
# ############
xgbfactors <- xgb.importance(colnames(train[-c(1:2)]), model=xgbmod)         
write_tsv(xgbfactors, "xgbfacsL3x.tsv", append = FALSE)

typenames <- fread("tts.txt")

# predict on the valset and evaluate results
xgbpred  <- predict(xgbmod, xgbtest)
probs <- t(matrix(xgbpred, nrow=38, ncol=length(xgbpred)/38))
colnames(probs) <- typenames[,tt]
submission <- cbind(test[, 1], probs)

write_csv(as.data.frame(submission), "L3xgb.csv")

