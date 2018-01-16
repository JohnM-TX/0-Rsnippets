# log it
mll <- min(xgbfirst[, test.mlogloss.mean])
logline <- data.frame(Sys.time(), "XGB", mll, bestround, numrounds, param0)
mll
write_csv(logline, "log.csv", append = TRUE)




comments <- "used vtreat on high cards"

logline <- data.table(Sys.time(), "XGB", score, bestround, numrounds, numfolds
                    , paste(param0, sep = ",", collapse = " "), comments)

fwrite(logline, "log.csv", append = TRUE)