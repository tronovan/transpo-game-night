#  These libraries need to be installed via:
#  install.packages("tm")
#  install.packages("SnowballC")
#  install.packages("wordcloud")


library(tm)
library(SnowballC)
library(wordcloud)


#  wordcloud_311 function
#  takes a csv file as input and outputs and svg file to the working directory

wordcloud_311 <-function(csv_file, svg_file){
  # read csv
  p <- read.csv(csv_file, stringsAsFactors = FALSE)
  
  # set the device as an svg file
  svg(filename=svg_file)
  
  # visit here for a better explination for this text mining stuff
  # https://www.r-bloggers.com/building-wordclouds-in-r/
  pCorpus <- Corpus(VectorSource(p$SR.Description))
  pCorpus <- tm_map(pCorpus, PlainTextDocument)
  pCorpus <- tm_map(pCorpus, removePunctuation)
  pCorpus <- tm_map(pCorpus, removeWords, stopwords('english'))
  pCorpus <- tm_map(pCorpus, stemDocument)
  wordcloud(pCorpus, max.words = 100, random.order = FALSE)
  
  # this saves the file to the working directory
  dev.off()
}

# set working directory
setwd("~/Data")

# call for each intersection using the data already prepared using the wrangle311.r script.
wordcloud_311("burnet_anderson.csv", "burnet_anderson.svg")
wordcloud_311("guadalupe_mlk.csv", "guadalupe_mlk.svg")
wordcloud_311("lamar_bartonsprings.csv", "lamar_bartonsprings.svg")
wordcloud_311("riverside_pleasantvalley.csv","riverside_pleasantvalley.svg")
wordcloud_311("rundberg_lamar.csv", "rundberg_lamar.svg")
wordcloud_311("fm969_sh130.csv", "fm969_sh130.svg")
