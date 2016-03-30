
library(readr)

# AUC blend by rank
best <- read_csv("submission8412.csv")
latest <-  read_csv("subens009.csv")

bestrank <- rank(best$TARGET,ties.method="first")
latestrank <- rank(latest$TARGET,ties.method="first")

qcfblend <- (0.55*bestrank + 0.45*latestrank)/nrow(best)

latest$TARGET <- qcfblend

write_csv(latest, "subens014.csv")





# simple blender
submission1 <- read_csv("subens11.csv")
submission2 <- read_csv("extra_trees45344.csv")

submission1[, -1] <-  0.9*submission1[, -1] + 0.1*submission2[, -1]
write_csv(submission1, "subens12.csv")



# monotonic
submission1 <- read_csv("subens09.csv")
submission1[, 2] <- 1.005 * submission1[, 2]
write_csv(submission1, "subadj002.csv")

# mean adjust
train <- read_csv("train.csv")
meantrain <- mean(train[, 2])
submission1 <- read_csv("subens12.csv")
meansub <- mean(submission1[, 2])
submission1[, 2] <- submission1[, 2] * meansub/meantrain   # this is opposite
write_csv(submission1, "subens12adj2.csv")
