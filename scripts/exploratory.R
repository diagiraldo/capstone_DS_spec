# Exploratory Data analysis
# I checked this post https://www.r-bloggers.com/how-to-create-unigrams-bigrams-and-n-grams-of-app-reviews/

setwd("~/capstone_DS_spec/")

# Load libraries
library("R.utils")
library("tidytext")
library("dplyr")
library("ggplot2")

# Fraction of data to load
fr <- 0.025

TS <- data.frame(source = c("news", "blogs", "twitter"),
                 nlines = NA, nread = NA)

# Read number of lines per source 
for (s in 1:3){
    infile <- sprintf("data/en_US/en_US.%s.txt", TS$source[s])
    TS$nlines[s] <- countLines(infile)
    TS$nread[s] <- round(TS$nlines[s]*fr)
}

# Read data from the three sources 
D <- data.frame(txt = character(sum(TS$nread)), stringsAsFactors = FALSE)
for (s in 1:3){
    infile <- sprintf("data/en_US/en_US.%s.txt", TS$source[s])
    con <- file(infile)
    tmp <- readLines(con, n = TS$nread[s])
    close(con)
    if (s == 1){
        tmp_idx <- seq(1, TS$nread[s])
    } else{
        tmp_idx <- seq((TS$nread[s-1] + 1), (TS$nread[s-1] + TS$nread[s]))
    }
    D[tmp_idx, 1] <- tmp  
    rm(tmp, tmp_idx)
}

# Frequency of n-grams
ng <- 1
freq <- D %>%
    unnest_tokens(output = n.gram, input = txt, token = "ngrams", n = ng) %>%
    count(n.gram, sort = TRUE)
head(freq)

# Plot
ntop <- 15
pl <- ggplot(freq[1:ntop,], aes(x = n.gram, y = n)) + geom_bar(stat = "identity") +
    labs(title  = sprintf("Frequency of the top %d %d-grams", ntop, ng)) + theme_minimal()
pl 

# How many unique words do you need in a frequency sorted dictionary 
# to cover 50% of all word instances in the language? 90%?

min(which(cumsum(freq$n) >= 0.9*sum(freq$n)))

# How do you evaluate how many of the words come from foreign languages?
fl <- is.na(iconv(freq$n.gram, from = "latin1", to = "ASCII")) & !(grepl("’", freq$n.gram))
freq$n.gram[fl]

# Can you think of a way to increase the coverage -
# - identifying words that may not be in the corpora or using a smaller number of words 
# in the dictionary to cover the same number of phrases?
