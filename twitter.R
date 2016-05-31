library(twitteR)
library(tm)
library(readr)
setwd("D:/Downloads")


setup_twitter_oauth("0HRKktageXDNpP74JSFxfopqH", "qANNESJ15RVjemgIaJirL4UdRBitqx1q4EIWOqaTmF5tioYUZ7", access_token="1946859516-wQfQztu7fe3CBIKc3KhmuqHhjVWcb6ZFjUlhHzK", access_secret="uuEeUQcD3nhyArstNXzYU9h5vZ31bXrwirWqHwm8gtESe")

me <- getUser("JohnMillerTX")
followers <- me$getFollowers(n=1000)

tframe <- do.call("rbind", lapply(followers, as.data.frame))
write_csv(tframe, "followers3.csv")
