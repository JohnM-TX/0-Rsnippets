# set dirs and load libraries
setwd("D:/Kaggles/Dato")
library(readr)
library(tm)
library(caret)

# create functions
fromspace <- content_transformer(function(x) gsub(" ", " SP ", x))
fromtab <- content_transformer(function(x) gsub("\t", "TB ", x))
spacer1 <- content_transformer(function(x) gsub("<", " < ", x))
puncstrip <- content_transformer(function(x) gsub("[^[:alnum:][:space:]<]", " ", x))
numsep <- content_transformer(function(x) gsub("(\\())([a-zA-Z])","\\1 \\2", x))
fromnums <- content_transformer(function(x) gsub("[[:digit:]]", " NB ", x))
sing1 <- content_transformer(function(x) gsub("categories", "category", x))
sing2 <- content_transformer(function(x) gsub(" comments ", " comment ", x))
sing4 <- content_transformer(function(x) gsub(" fonts ", " font ", x))
sing5 <- content_transformer(function(x) gsub(" forms ", " form ", x))
sing6 <- content_transformer(function(x) gsub(" images ", " image ", x))
sing7 <- content_transformer(function(x) gsub(" sites ", " site ", x))
sing8 <- content_transformer(function(x) gsub(" themes ", " theme ", x))
sing9 <- content_transformer(function(x) gsub(" tags ", " tag ", x))

mewords1 <- content_transformer(function(x) gsub(" i ", " me ", x))
mewords2 <- content_transformer(function(x) gsub(" my ", " me ", x))
youwords1 <- content_transformer(function(x) gsub(" youll ", " you ", x))
youwords2 <- content_transformer(function(x) gsub(" your ", " you ", x))
youwords3 <- content_transformer(function(x) gsub(" youre ", " you ", x))

mapfuns <- list(sing1,
                sing2,
                sing4,
                sing5,
                sing6,
                sing7,
                sing8,
                sing9,
                mewords1,
                mewords2,
                youwords1,
                youwords2,
                youwords3,
                spacer1,
                fromnums,
                fromspace,
                stripWhitespace,
                puncstrip,
                fromtab, 
                content_transformer(tolower)) # these run from right to left inside tm_reduce

dtmctrl <- list(dictionary=read_lines("wordlist.csv"),
                wordLengths = c(1, Inf),
                weighting=weightTf) 
                # weighting = function(x)
                # weightSMART(x, spec="ann")) # use bnn for binary


pullin <- function(x) Corpus(DirSource(file.path(paste("D:/Kaggles/Dato/texttests/texttest", x, sep=""))))   # change as needed
preproc <- function(x) tm_map(x, FUN=tm_reduce, tmFuns=mapfuns)
dtmbuild <- function(x) DocumentTermMatrix(x, control=dtmctrl)

# smartpaste <- function(x) eval(parse(text=paste0(x)))  -- buggy...

for(i in 1:12)
{
  cat("starting batch ", paste(i), "\t")
  assign(paste0("docstest", i), pullin(i))
  cat("preprocessing ", paste(i), "\t")
  assign(paste0("docstest", i), preproc(eval(parse(text=paste0("docstest", i)))))
  cat(paste0("building dtmtest", i), "\n")
  assign(paste0("dtmtest", i), dtmbuild(eval(parse(text=paste0("docstest", i)))))
  assign(paste0("mxtest", i), as.matrix(eval(parse(text=paste0("dtmtest", i)))))
  assign(paste0("docstest", i), NULL)
  assign(paste0("dtmtest", i), NULL)
}  

allmxs <- lapply(1:12, function(x) eval(parse(text=paste("mxtest", x, sep=""))))
mxtest <- do.call(rbind, allmxs) 

dftest <- as.data.frame(mxtest)
testlabels <- read_csv("filesizesall.csv")
somelabels <- match(row.names(dftest), testlabels[, 1])
dftest <- cbind(row.names(dftest),testlabels[somelabels, 2], rowSums(dftest), dftest)
colnames(dftest)[1:3] <- c("filename", "filesize", "filelength")


dftest$spratio <- dftest$sp/dftest$filesize
dftest$tagratio <- dftest$`<`/dftest$filesize
dftest$numratio <- dftest$nb/dftest$filesize

# log10 transform filesize and length if using ann weighting for dtm

write_csv(dftest, "dtmtest.csv")
