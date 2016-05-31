
library(readr)

# AUC blend by rank
best <- read_csv("submissionshah.csv")
latest <-  read_csv("subens035.csv")
bestrank <- rank(best$TARGET,ties.method="first")
latestrank <- rank(latest$TARGET,ties.method="first")
qcfblend <- (0.9*bestrank + 0.1*latestrank)/nrow(best)
latest$TARGET <- qcfblend
write_csv(latest, "subens036.csv")



# simple blender
submission1 <- read_csv("subnewlast2.csv")
submission2 <- read_csv("subnewlastfeed.csv")
submission1[, -1] <-  0.9*submission1[, -1] + 0.1*submission2[, -1]
write_csv(submission1, "subnewlast5.csv")





# monotonic
submission1 <- read_csv("subens13adj1.csv")
submission1[, 2] <- 0.9955 * submission1[, 2]
write_csv(submission1, "subens13adj2.csv")


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


