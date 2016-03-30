# count files in folders

filecount <- vector(mode="integer", length = 500)
for (i in 1:500) {
  filecount[i] <- length(list.files(paste0("D:/Kaggles/ScienceBowl/train/",i), recursive=TRUE))
}