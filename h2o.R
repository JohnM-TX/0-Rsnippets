library(h2o)
localh2o <- h2o.init(nthreads=-1, max_mem_size = "6G")
train.hex <- as.h2o(train, destination_frame = "train.hex")

test.hex <- as.h2o(test, destination_frame = "test.hex")

# go to web interface localhost:54321
# build gbm 
# predict onto the test set
# pull back into R

preds <- read_csv("preds.csv")
submission <- data.frame(id=testids)
submission$target <- preds$Y
write_csv(submission, "gbmh2ogaussian.csv")

h2o.shutdown()
y
