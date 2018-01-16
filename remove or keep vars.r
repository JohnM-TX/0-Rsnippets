
# clean up and save
keepers <- c("test", "train", "val")
rm(list= ls()[!(ls() %in% keepers)])
save.image("modelbigflag.RData")







