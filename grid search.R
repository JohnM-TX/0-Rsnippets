# script to run home made grid search

for (e in etas) {
  for (d in depths) {
    for (mcw in mcws) {
      
      cv = xgb.cv(param=cv.param, data = trainMatrix, label = y, maximize = FALSE, 
                  nfold = cv.nfold, nrounds = cv.nround, verbose = FALSE, early.stop.round = cv.esr, 
                  eval_metric = "logloss")
    }
  }
}

m = min(cv$test.logloss.mean)
r = which(cv$test.logloss.mean == m)[1]