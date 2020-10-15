# Goal: To bould a first simple model for the relatinships between words

library("markovchain")
library("dplyr")

# Basi example
short_text <- c("the quick brown fox jumps over the lazy dog and the angry dog chase the fox")
text_term <- strsplit(short_text, split = " ") %>% unlist()
fit_markov <- markovchainFit(text_term, method = "laplace")
markovchainSequence(n = 4, markovchain = fit_markov$estimate, t0 = "dog", include.t0 = T)


        
# Find n-grams and list of units that follow those n-grams


# For our purposes, the term “Markov chain” is synonymous with 
# “text generated from n-gram model probability tables,” (https://www.decontextualize.com/teaching/rwet/n-grams-and-markov-chains/)

# Goal: To bould a first simple model  for the relatinships between words

# From wiki : An n-gram model is a type of probabilistic language model for predicting 
# the next item in such a sequence in the form of a (n − 1)–order Markov model.
# Note that in a simple n-gram language model, the probability of a word, conditioned on 
# some number of previous words (one word in a bigram model, two words in a trigram model, etc.) 
# can be described as following a categorical distribution

# How with Markov chains

# Tasks:
# 1. Build a basin n-gram model for predicting the next word given the previous 1-3 words
# 2. Build a model to handle unseen n-grams

# To take into account the different n, use the https://en.wikipedia.org/wiki/Katz%27s_back-off_model

# Handle words that have not seen  before
# This is the "smoothing": Laplace Smoothing add \lambda to all counts including non-zero counts.
# Good-Turing method
# https://staff.fnwi.uva.nl/k.simaan/D-Courses2013/D-NLMI2013/college3.pdf

# Think about time efficiency 

# Think about evaluation