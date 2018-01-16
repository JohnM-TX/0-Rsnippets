library(data.table)
library(FeatureHashing)
library(Matrix)
library(xgboost)

df <- fread("../input/train.csv", data.table = F)

# set names of character and numeric features
X_char <- names(df)[sapply(df, is.character)]
X_num  <- setdiff(names(df), c(X_char, "ID", "target"))

# hash characters and retain only more frequent ones
d1 <- hashed.model.matrix(~. , df[ , X_char], signed.hash = F)
d1 <- d1[ , colSums(d1) > 20]

# set numeric NAs to -1
d2 <- df[ , X_num]
d2[is.na(d2)] <- -1

# bind all features with cBind (not cbind) to keep sparse
d3 <- cBind(d1, as.matrix(d2))

# check size of resulting matrix
dim(d3)
print(object.size(d3), units = "Mb")

# minimal xgboost example (untuned, small number of rounds)
dmodel <- xgb.DMatrix(d3, label = df$target)

param  <- list(objective = "binary:logistic", eta = 0.05,
               max_depth = 5, subsample = 0.5)

cv <- xgb.cv(nfold = 2, metrics = "logloss", print = 10,
             nrounds = 100, params = param, data = dmodel)
