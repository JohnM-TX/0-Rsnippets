
################# drop low-gain variables for L2 #########


drops <- fread("drops.txt")
drops <- as.character(drops[, V1])

train <- fread("L2train.csv", header = T)
train[, (drops) := NULL]
val <- fread("L2val.csv", header = T)
val[, (drops) := NULL]

setDF(train)
setDF(val)

###############################