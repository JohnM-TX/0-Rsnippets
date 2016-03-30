library(reshape2)
setwd("D:/Kaggles")

A <- rnorm(200,mean=5,sd=1)
B <- rnorm(200,mean=7,sd=1.5)
C <- rnorm(200,mean=9,sd=2)
stats <- data.frame(id=seq(1, 200, by = 1), A=A, B=B, C=C)
stats2 <- melt(stats, id = "id")
write.csv(stats2, "stats2.csv")



names(airquality) <- tolower(names(airquality))
melt(airquality, id=c("month", "day"))
names(ChickWeight) <- tolower(names(ChickWeight))
melt(ChickWeight, id=2:4)