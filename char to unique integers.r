


# alternate method
for (f in names(train)) {
  if (class(train[[f]])=="character") {
    levels <- unique(c(train[[f]], test[[f]]))
    train[[f]] <- as.integer(factor(train[[f]], levels=levels))
    test[[f]]  <- as.integer(factor(test[[f]],  levels=levels))
  }
}

# for single set
for (f in names(train)) {
  if (class(train[[f]])=="character") {
    levels <- unique(train[[f]])
    train[[f]] <- as.integer(factor(train[[f]], levels=levels))
  }
}

# single column data table way
levels <- unique(dt[, mycolumn])
dt[, newtype := as.integer(factor(mycolumn, levels))]


# change all columns
dt[, names(dt) := lapply(.SD, as.numeric)]