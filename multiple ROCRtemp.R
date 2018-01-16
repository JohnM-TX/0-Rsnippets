library(ROCR)

xgbpreds <- prediction(xgbp, val[, 2])


bl0 <- performance(pred0, "tpr", "fpr")
rc1 <- performance(pred1, "tpr", "fpr")
rc2 <- performance(pred2, "tpr", "fpr")
rc3 <- performance(pred3, "tpr", "fpr")

plot(bl0, col="red")
plot(rc1, col="blue", add=TRUE)
plot(rc2, col="green", add=TRUE)
plot(rc3, col="orange", add=TRUE)

score1 <- performance(pred1, "auc")
score2 <- performance(pred2, "auc")
score3 <- performance(pred3, "auc")

cat("AUC:", "\t", paste(score1@y.values), "\n"
    , "\t", paste(score2@y.values), "\n"
    , "\t", paste(score3@y.values), "\n"
    )

