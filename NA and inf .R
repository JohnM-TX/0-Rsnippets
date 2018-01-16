

# INF
for (j in 1:ncol(trainmain)) set(trainmain, which(is.infinite(trainmain[[j]])), j, NA)

# NA
for (j in seq_len(ncol(alldata))) set(alldata,which(is.na(alldata[[j]])),j,-1)

# NA
trainmain[is.na(trainmain)] <- -1

# Identify NAs
names(which(colSums(is.na(mymatrix))>0))

# count NAs per column
na_count <-sapply(x, function(y) sum(length(which(is.na(y)))))



#fill NAs forward

# write function to fill NAs
na_locf <- function(dt, coll) {
  setnames(dt, coll, "colNa")
  dt[, segment := cumsum(!is.na(colNa))]
  dt[, colNa := colNa[1], by = "segment"]
  dt[, segment := NULL]
  setnames(dt, "colNa", coll)
  return(dt)
}

library(ggplot2)
ggplot(payroll, aes(x=Hours_Worked_Amt))+
stat_density(aes(y=..count..), color="black", fill="blue", alpha=0.3)+
scale_x_log10(breaks = c(30, 40))

            paynegs <- (payroll[Hours_Worked_Amt<0, ])

