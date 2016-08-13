library(tm)
library(wordcloud)
library(memoise)

# The list of using files
sets <<- list("From July 2015 to July 2016" = "new",
              "From July 2006 to July 2007" = "middle",
              "From July 1998 to July 1999" = "old")

getTermMatrix <- memoise(function(set) {
    if (!(set %in% sets))
        stop("Unknown set")
    
    text <- readLines(sprintf("./%s.txt.gz", set), encoding="UTF-8")
    
    myCorpus = Corpus(VectorSource(text))
    myCorpus = tm_map(myCorpus, content_transformer(tolower))
    myCorpus = tm_map(myCorpus, removePunctuation)
    myCorpus = tm_map(myCorpus, removeNumbers)
                                                                                    
    myStopWords <- c("existing", "abstract", "acknowledgements", "altshuller", 
                     "applied", "apply", "article", "base", "based", "best", 
                     "case", "conclusions", "due", "fig", "figure", "find", 
                     "found", "good", "high", "higher", "important",
                     "introduction", "large", "lean", "lens","level", 
                     "levels", "light", "low", "made", "main", "make", "matrix", 
                     "means", "needed", "order", "part", "parts", "principle",
                     "principles", "problem", "problems", "qfd", "references", 
                     "related", "set", "shown", "similar", "simple", "small", 
                     "snr", "solutions", "suh", "system", "table", "theory", 
                     "tool", "tools", "triz", "typical", "ways", "work",
                     "working", "years", "zlotin")
    
    myCorpus = tm_map(myCorpus, removeWords, c(stopwords("SMART"), myStopWords))
    
    myDTM = TermDocumentMatrix(myCorpus, control = list(minWordLength = 3))
    
    m = as.matrix(myDTM)
    
    sort(rowSums(m), decreasing = TRUE)
    
})