# log it
mll <- min(xgbfirst[, test.mlogloss.mean])
logline <- data.frame(Sys.time(), "XGB", mll, bestround, numrounds, param0)
mll
write_csv(logline, "log.csv", append = TRUE)