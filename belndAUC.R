# AUC blend by rank

library(data.table)

prep <- function(fl) {
  dt <- fread(fl)
  setorder(dt, id)
  rankvec <- frank(dt[, target], ties.method="first")
  return(rankvec)
  }

filenoms <- list.files(getwd())
subfiles <- sapply(filenoms, prep)

weights <- c(0.25, 0.15, 0.25, 0.35)

rank_vector <- subfiles %*% weights

sample <- fread("../sample_submission.csv")
sample[, target := round(rank_vector/nrow(sample), 4)]
fwrite(sample, "../ens005.csv")





# monotonic
submission1 <- fread("submission_001.csv", header = TRUE)
matr <- submission1[, 2:7, with = FALSE]
matr <- round(matr*0.9, 4)

submono <- cbind(ParcelID = submission1$ParcelId, matr)
fwrite(submono, "submono_09.csv")
