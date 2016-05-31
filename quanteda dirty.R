setwd("D:/Dropbox (Personal)/Desktop/UpWork/Primer")
library(data.table)
library(quanteda)
comments <- fread("surveycopy4c.csv", select = "Open_Feedback")
comments <- comments[Open_Feedback != "", 1, with = FALSE]
mycrps <- corpus(comments$Open_Feedback)
summary(mycrps, n=5)
tokeninfo <- texts(mycrps)

mydtm <- dfm(mycrps)
mydtm[1:10, 1:5]
topfeatures(mydtm, 50)

mydtm2 <- dfm(mycrps, ignoredFeatures = stopwords("english"))
topfeatures(mydtm2, 20)

png(filename="cloud45.png",
    type="cairo",
    bg="transparent",
    units="in",
    width=7,
    height=6,
    pointsize=10,
    res=300)

plot(mydtm2, max.words = 80, colors = brewer.pal(6, "Blues"), random.order=FALSE, rot.per=0.35,scale = c(4, 1))

dev.off()

tokens <- tokenize(mycrps, removePunct = TRUE, simplify = TRUE)
nnn <- ngrams(tokens, n = 2:3)
mydtm <- dfm(nnn)
tf3 <- as.data.frame(topfeatures(mydtm, 50))
write.csv(tf3,"tf3.csv")
