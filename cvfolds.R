
# THIS (1)

#best
library(caret)
numfolds = 8
trainindex <- createFolds(train$interest_level, k = numfolds)
for (i in 1:numfolds) {
  assign(paste0("val",i), train[trainindex[[paste0("Fold", i)]], ])
  assign(paste0("train",i), train[-trainindex[[paste0("Fold", i)]], ])
}



# OR THIS (2)

library(data.table)
library(readr)
set.seed(333)

# base file 'train'
idnumsh <- unique(train[, VisitNumber])
s <- sample(1:length(idnumsh))
s2 <- floor(s/((1+length(idnumsh))/5))
foldTable <- data.frame(VisitNumber=idnumsh)
foldTable$fold <- s2+1

all <- cbind(foldTable, train)



setDT(all)

valA <- all[fold==1, -1, with=FALSE]
valB <- all[fold==2, -1, with=FALSE]
valC <- all[fold==3, -1, with=FALSE]
valD <- all[fold==4, -1, with=FALSE]
hold <- all[fold==5, -1, with=FALSE]

trainA <- rbind(valB, valC, valD)
trainB <- rbind(valA, valC, valD)
trainC <- rbind(valB, valA, valD)
trainD <- rbind(valB, valC, valA)

write_csv(trainA, "trainA.csv")
write_csv(trainB, "trainB.csv")
write_csv(trainC, "trainC.csv")
write_csv(trainD, "trainD.csv")
write_csv(valA, "valA.csv")
write_csv(valB, "valB.csv")
write_csv(valC, "valC.csv")
write_csv(valD, "valD.csv")
write_csv(hold, "hold.csv")