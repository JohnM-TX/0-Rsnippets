for (f in countflaggers) {
    valuecount <- ave(traintemp[[f]], traintemp[[f]],  FUN = length)
    train[, paste0(f, "count")] <- valuecount
}