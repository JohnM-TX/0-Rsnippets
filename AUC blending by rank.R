library(readr)


best <- read_csv("xgbensnew40.csv")
latest <-  read_csv("L1xgbraw33.csv")

bestrank <- rank(best$QuoteConversion_Flag,ties.method="first")
latestrank <- rank(latest$QuoteConversion_Flag,ties.method="first")

qcfblend <- (0.9*bestrank + 0.1*latestrank)/nrow(best)

latest$QuoteConversion_Flag <- qcfblend

write_csv(latest, "xgbensnew44.csv")
