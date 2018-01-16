# BADASS LISTING PROGRAM!

# set dirs and load libraries
set.seed(210)
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

mapfuns <- list(sing1, sing2, sing4, sing5, sing6, sing7, sing8, sing9,
                mewords1, mewords2,
                youwords1, youwords2, youwords3,
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

# preprocess text and produce dtms
# library(foreach)
# library(doSNOW)                                    # use this next time
# cl <- makeCluster(4, type='SOCK')
# registerDoSNOW(cl)

pullin <- function(x) Corpus(DirSource(file.path(paste("D:/Kaggles/Dato/texttrains/dir", x, sep=""))))   # change as needed
preproc <- function(x) tm_map(x, FUN=tm_reduce, tmFuns=mapfuns)
dtmbuild <- function(x) DocumentTermMatrix(x, control=dtmctrl)

for(i in 1:17)
{
  cat("starting batch ", paste(i), "\t")
  assign(paste0("docstrain", i), pullin(i))
  assign(paste0("docstrain", i), preproc(eval(parse(text=paste0("docstrain", i)))))
  cat(paste0("building dtmtrain", i), "\n")
  assign(paste0("dtmtrain", i), dtmbuild(eval(parse(text=paste0("docstrain", i)))))
  assign(paste0("mxtrain", i), as.matrix(eval(parse(text=paste0("dtmtrain", i)))))
  assign(paste0("docstrain", i), NULL)
  assign(paste0("dtmtrain", i), NULL)
}  

allmxs <- lapply(1:17, function(x) eval(parse(text=paste("mxtrain", x, sep=""))))
mxtrain <- do.call(rbind, allmxs)
dftrain <- as.data.frame(mxtrain)
trainlabels <- read_csv("train_v2.csv")
somelabels <- match(row.names(mxtrain), trainlabels[, 1])
dftrain <- cbind(row.names(dftrain),trainlabels[somelabels, 2:3], rowSums(dftrain), dftrain)
colnames(dftrain)[1:4] <- c("filename", "sponsored", "filesize", "filelength")

dftrain$spratio <- dftrain$sp/dftrain$filesize
dftrain$tagratio <- dftrain$`<`/dftrain$filesize
dftrain$numratio <- dftrain$nb/dftrain$filesize


# dftrain$filesize <- log10(dftrain$filesize)
# dftrain$filelength <- log10(dftrain$filelength)
# add/remove extra columns vs. existing dtmtrain
write_csv(dftrain, "dtmtrain.csv")
