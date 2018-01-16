# script to run home made grid search

scores <- " "
for (cst in csts) {
  for (csl in csls) {
    for (ssm in ssms) {
        xgbfirst <- xgb.cv(data=xgbtrain
                   , params = param0
                   , nrounds = numrounds 
                   , print_every_n = 10L
                   , colsample_bytree = cst
                   , colsample_bylevel = csl
                   , subsample = ssm
                  , verbose = 1
                   , nfold = nfolds
                   , early.stop.round = 20
  ) 
  score <- min(xgbfirst$test.mlogloss.mean)
  scores <- paste(scores, cst, csl, ssm, score, ";")
    }
  }
}