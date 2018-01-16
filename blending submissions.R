
library(data.table)
library(readr)

# AUC blend by rank
primo <- fread("submission_0.586.csv")
setorder(primo, File)
segundo <- fread("submission_0.572.csv")
setorder(segundo, File)
tercero <- fread("submission_0.56.csv")
setorder(tercero, File)
rango1 <- rank(primo[, 2, with = FALSE],ties.method="first")
rango2 <- rank(segundo[, 2, with = FALSE],ties.method="first")
rango3 <- rank(tercero[, 2, with = FALSE],ties.method="first")
qcfblend <- (0.50*rango1 + 0.25*rango2 + 0.25*rango3)/nrow(primo)
tercero[, 2 := qcfblend, with = FALSE]
fwrite(tercero, "ens013.csv")



# simple blender
submission1 <- fread("sub_1.165.csv")
setorder(submission1, image)
submission2 <- fread("sub_1.188.csv")
setorder(submission2, image)
subpart3 <-  0.8*submission1[, !"image", with = FALSE] + 0.2*submission2[, !"image", with = FALSE]
submission3 <- cbind(subpart3, submission1[, image])
setnames(submission3, "V2", "image")
fwrite(submission1, "subens004.csv")


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


