actuals <- fread("valkey.csv")
mll <- MultiLogLoss(actuals[, 3:40, with=FALSE], probs)
logline <- data.frame(Sys.time(), mll)
write_csv(logline, "log.csv", append = TRUE)
