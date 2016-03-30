
### Examine NAs using mice and VIM packages ###

# read file and convert char to int
library(readr)
test <- read_csv("test.csv")

for (f in names(test)) {
  if (class(test[[f]])=="character") {
    levels <- unique(test[[f]])
    test[[f]] <- as.integer(factor(test[[f]], levels=levels))
  }
}

# make a table of missing values
library(mice)
missers <- md.pattern(test[, -c(1:2)])
head(missers)
write_csv(as.data.frame(missers),"NAsTable.csv")

# make plots of missing values
library(VIM)

png(filename="NAsPattern1.png",
    type="cairo",
    units="in",
    width=12,
    height=6.5,
    pointsize=10,
    res=300)

# this version shows each row clearly 
miceplot1 <- aggr(test[, -c(1:2)], col=c("dodgerblue","dimgray"),
                 numbers=TRUE, combined=TRUE, varheight=FALSE, border="gray50",
                 sortVars=TRUE, sortCombs=FALSE, ylabs=c("Missing Data Pattern"),
                 labels=names(test[-c(1:2)]), cex.axis=.7)
dev.off()

png(filename="NAsPattern2test.png",       # use this device for scalable, high-res graphics
    type="cairo",
    units="in",
    width=12,
    height=6.5,
    pointsize=10,
    res=300)

# this version visually shows the data by volume
miceplot2 <- aggr(test[, -c(1)], col=c("dodgerblue","dimgray"),
                 numbers=TRUE, combined=TRUE, varheight=TRUE, border=NA,
                 sortVars=TRUE, sortCombs=FALSE, ylabs=c("Missing Data Pattern w/ Height Adjustment"),
                 labels=names(test[-c(1)]), cex.axis=.7)
dev.off()

