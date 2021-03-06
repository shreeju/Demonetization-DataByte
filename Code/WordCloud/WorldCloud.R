library("twitteR")
library("tm")
library("SnowballC")
library("wordcloud")
library("RCurl")
library("stringr")
library("ggplot2")
library("readr")

dataset <- read_csv("~\\Datasets\\demonetization-tweets.csv")

tweet = dataset$text

tweet = gsub("[[:cntrl:]]", " ", tweet)
tweet <- gsub("(RT|via)((?:\\b\\W*@\\W+)+)", " ", tweet, ignore.case = T)
tweet <- gsub('@\\w+', '', tweet)
tweet <- gsub("[[:punct:]]"," ", tweet)
tweet <- gsub("[[:digit:]]"," ", tweet)
tweet <- gsub("http[s]?\\w+", " ", tweet)
tweet <- gsub("[ \t]{2,}", " ", tweet)
tweet <- gsub("^\\s+|\\s+$", " ", tweet)
tweet <- tweet[!is.na(tweet)]
tweet = gsub("^ ", "", tweet)
tweet = gsub(" $", "", tweet)
tweet = gsub("[^[:alnum:] ]", " ", tweet)

tweet = tolower(tweet)

tweet_corpus = Corpus(VectorSource(tweet))
tweet_corpus <- tm_map(tweet_corpus, tolower)
tweet_corpus <- tm_map(tweet_corpus, PlainTextDocument)
tweet_corpus <- tm_map(tweet_corpus, removePunctuation)
tweet_corpus = tm_map(tweet_corpus, removeWords, c("demonetization","demonetisation","rt","amp", stopwords("english")))
tweet_corpus <- tm_map(tweet_corpus, stripWhitespace)
tweet_corpus = tm_map(tweet_corpus, stemDocument)

wordcloud(tweet_corpus, min.freq = 150, max.words = 300, random.order = 'F', rot.per = 0.2, colors = brewer.pal(8, "Dark2"), random.color = TRUE, scale = c(3,.3))
