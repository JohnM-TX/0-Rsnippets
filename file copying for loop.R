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