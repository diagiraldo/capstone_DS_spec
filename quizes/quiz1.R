library(R.utils)

setwd("~/capstone_DS_spec/")

#Q2
countLines("data/en_US/en_US.twitter.txt")

#Q3
sr <- "blogs"
con <- file(sprintf("data/en_US/en_US.%s.txt", sr))
A <- readLines(con)
close(con)
max(nchar(A))

#Q4
sr <- "twitter"
con <- file(sprintf("data/en_US/en_US.%s.txt", sr))
A <- readLines(con)
close(con)
sum(grepl("love", A))/sum(grepl("hate", A))

#Q5
grep("biostats", A, value = TRUE)

#Q6
grep("^A computer once beat me at chess, but it was no match for me at kickboxing$", A, value = TRUE)