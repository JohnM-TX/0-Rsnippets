library("seriation")
data("iris")
x <- as.matrix(iris[-5])
y <- x[sample(seq_len(nrow(x))),]
d <- dist(y)
o <- seriate(d)
o
pimage(d, main = "Random")
pimage(d, o, main = "Reordered")
