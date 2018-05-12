if ("mscstexta4r" %in% installed.packages()[, "Package"] == FALSE)
{
  install.packages("mscstexta4r")
}

library("mscstexta4r")
textaInit()

mscstafunc <- function(docsText) {
  docsLanguage <- rep("en", length(docsText))
  
  # Perform sentiment analysis
  tryCatch({
    docsSentiment <- textaSentiment(documents = docsText,
                                    languages = docsLanguage)
    
  }, error = function(err) {
    # Print error
    geterrmessage()
    
  })
  class(docsSentiment)
  docsSentiment
  
  resp <- docsSentiment$results
  resp$text
  resp$score
  
  
  # Get key talking points in documents
  tryCatch({
    docsKeyPhrases <- textaKeyPhrases(documents = docsText,
                                      languages = docsLanguage)
  }, error = function(err) {
    # Print error
    geterrmessage()
    
  })
  
  class(docsKeyPhrases)
  docsKeyPhrases
  
  resp1 <- docsKeyPhrases$results
  resp1$text
  resp1$keyPhrases
  
  result <- c(docsText, resp$score, resp1$keyPhrases)
  return(result)
}

fileName <- "C:\\Users\\xinxue\\tmp\\test.txt"
conn <- file(fileName, open = "r")
linn <-readLines(conn)
close(conn)

r <- mscstafunc(c(linn[1:length(linn)]))
print(r)
for (i in 1:length(linn)){
  myApp <- TRUE
  cat(r[[i]],"\t", file="C:\\Users\\xinxue\\tmp\\output.txt", append=myApp, sep=' ')
  cat(r[[i+length(linn)]],"\t", file="C:\\Users\\xinxue\\tmp\\output.txt", append=myApp, sep=' ')
  cat(r[[i+2*length(linn)]],"\n", file="C:\\Users\\xinxue\\tmp\\output.txt", append=myApp, sep=' ')
