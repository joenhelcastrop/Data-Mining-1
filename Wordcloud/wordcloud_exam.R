setwd("D:/rprogramming")

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

set.seed(1234)
feedback_file <- "feedback.txt"
cat("Using existing", feedback_file, "\n")

# Part 1
raw_lines <- readLines(feedback_file, encoding = "UTF-8", warn = FALSE)
raw_text <- paste(raw_lines, collapse = " ")

docs <- Corpus(VectorSource(raw_text)) 

docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, stemDocument, language = "english")


# Part 2
tdm <- TermDocumentMatrix(docs, control = list(wordLengths = c(1, Inf)))
m <- as.matrix(tdm)
v <- rowSums(m)
word_freq <- sort(v, decreasing = TRUE)

d <- data.frame(
  word = names(word_freq),
  freq = as.integer(word_freq),
  stringsAsFactors = FALSE
)

cat("Top 10 most frequent words:\n")
print(head(d, 10))

# The most used words in the feedback are “high” and “recommend,”
# both showing up 406 times. That means a lot of people gave strong praise. 
# Other common words like “quick,” “process,” and “love” suggest good experiences and fast service. 
# “Communic” probably came from “communication,” showing that interaction mattered too. Overall,
# the feedback feels positive and efficient.

freq_vec <- setNames(d$freq, d$word)

png(filename = "wordcloud_exam.png", width = 800, height = 600)

wordcloud(
  names(freq_vec),
  freq = freq_vec,
  min.freq = 2,
  max.words = 1000,
  random.order = FALSE,
  colors = brewer.pal(8, "Dark2"),
  scale = c(4, 0.5) 
)
dev.off()


# Part 4

rare_words_df <- d[d$freq == 1, ]

if (nrow(rare_words_df) == 0) {
  cat("NOTE: No words with frequency = 1 found.\n")
  tail_n <- min(5, nrow(d))
  rare_words_df <- tail(d, n = tail_n)
  plot_min_freq <- min(rare_words_df$freq)
} else {
  plot_min_freq <- 1
}

top_5_rare_keywords <- head(rare_words_df, 5)

print("Top 5 Least Frequent Keywords (Plotting using Actual Minimum Frequency):")
print(top_5_rare_keywords)

png("wordcloud_rare.png", width=800, height=600, res=100) 

wordcloud(
  words = top_5_rare_keywords$word,
  freq = top_5_rare_keywords$freq,
  min.freq = plot_min_freq,
  max.words = 5,
  random.order = FALSE,
  scale = c(3, 0.5),
  rot.per = 0.2,
  colors = brewer.pal(5, "Set1")
)
dev.off()
