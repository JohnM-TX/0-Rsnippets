library(twitteR)
library(RColorBrewer)
library(colorspace)
library(wordcloud)
library(tm)
setwd("E:/Viivo/Biz/collateral")


setup_twitter_oauth("0HRKktageXDNpP74JSFxfopqH", "qANNESJ15RVjemgIaJirL4UdRBitqx1q4EIWOqaTmF5tioYUZ7", access_token="1946859516-wQfQztu7fe3CBIKc3KhmuqHhjVWcb6ZFjUlhHzK", access_secret="uuEeUQcD3nhyArstNXzYU9h5vZ31bXrwirWqHwm8gtESe")


tweets <- searchTwitter("thrivent", n=1000)
tweets <- strip_retweets(tweets)

tframe <- do.call("rbind", lapply(tweets, as.data.frame))
tframe <- tframe[tframe$screenName != "Thrivent", ]
tvec <- tframe[tframe$screenName != "kenzgrondahl", "text"] # pulls out a problematic tweet

tcorp <- Corpus(VectorSource(tvec))

# puncout <- content_transformer(function(x) gsub("[^[a-zA-Z][:space:]]", " ", x))
# nixer <- content_transformer(function(x) gsub("½í", " ", x))
# 
# 
# t2 <- tm_map(tcorp, puncout)
# t2 <- tm_map(t2, removeWords, stopwords("english")) 
# 
# t2 <- tm_map(t2, nixer)
# 
# t2 <- tm_map(t2, tolower)



dtmctrl <- list(removePunctuation = TRUE
              , removeNumbers = TRUE
              , stopwords = TRUE
              , tolower = TRUE
              , wordLengths = c(3, Inf)
              , weighting=weightTf)

tmat <- TermDocumentMatrix(tcorp, control = dtmctrl)
tmat <- as.matrix(tmat)

tdf <- data.frame(word=rownames(tmat), freq=rowSums(tmat), stringsAsFactors = FALSE)
tdf <- tdf[tdf$word != "thrivent", ]

ctext <- tdf

png(filename="cloud45.png",
    type="cairo",
    bg="transparent",
    units="in",
    width=7,
    height=6,
    pointsize=10,
    res=300)

set.seed(213)
wordcloud(words = ctext$word, freq = ctext$freq, scale=c(4, 1), min.freq = 3,
          max.words=50, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(6, "Blues"))

dev.off()