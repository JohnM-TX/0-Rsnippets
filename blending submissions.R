

library(readr)

# AUC blend by rank
best <- read_csv("subens010.csv")
best <- best[order(best$activity_id),]
latest <-  read_csv("mod3108Kaggle_01-1.csv")
latest <- latest[order(latest$activity_id),]
bestrank <- rank(best[, 2],ties.method="first")
latestrank <- rank(latest[, 2],ties.method="first")
qcfblend <- (0.9*bestrank + 0.1*latestrank)/nrow(best)
latest[, 2] <- qcfblend
write_csv(latest, "subens011.csv")



# simple blender
submission1 <- fread("subens009.csv")
setorder(submission1, id)
submission2 <- fread("submit2.csv")
setorder(submission2, id)
subpart3 <-  0.9*submission1[, -1, with=FALSE] + 0.1*submission2[, -1, with=FALSE]
submission1[, Demanda_uni_equil := subpart3]
write_csv(submission1, "subens010.csv")


#alt
submission1[, -11] <-  0.9*submission1[, -11] + 0.1*submission2[, -11]
write_csv(submission1, "subens002.csv")



# monotonic
submission1 <- read_csv("subens010.csv")
submission1[, 2] <- 0.9955 * submission1[, 2]
write_csv(submission1, "subens10adj3.csv")


# mean adjust
train <- read_csv("train.csv")
meantrain <- mean(train[, 2])
submission1 <- read_csv("subens23adj2.csv")
meansub <- mean(submission1[, 2])
submission1[, 2] <- submission1[, 2] * meansub/meantrain   # this is opposite
write_csv(submission1, "subens23adj3.csv")


# format fixer
submissionaccept <- read_csv("submissionext.csv")
submissionreject <- read_csv("submissionxgb.csv")
submissionaccept[, 2] <-  submissionreject[, 2]
write_csv(submissionaccept, "submissionxgbredo.csv")


