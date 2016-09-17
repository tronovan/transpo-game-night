#  These libraries need to be installed via:
#  install.packages("tm")
#  install.packages("SnowballC")
#  install.packages("wordcloud")


library(tm)
library(SnowballC)
library(wordcloud)


#  apd_wordcloud function
#  takes a csv file as input and outputs and svg file to the working directory

apd_wordcloud<-function(csv_file, svg_file){
  # read csv
  p <- read.csv(csv_file, stringsAsFactors = FALSE)
  
  # set the device as an svg file
  svg(filename=svg_file)
  
  # visit here for a better explination of this text mining stuff
  # https://www.r-bloggers.com/building-wordclouds-in-r/
  pCorpus <- Corpus(VectorSource(p$Crime.Type))
  pCorpus <- tm_map(pCorpus, PlainTextDocument)
  pCorpus <- tm_map(pCorpus, removePunctuation)
  pCorpus <- tm_map(pCorpus, removeWords, stopwords('english'))
  pCorpus <- tm_map(pCorpus, stemDocument)
  wordcloud(pCorpus, max.words = 100, random.order = FALSE)
  
  # this saves the file to the working directory
  dev.off()
}

# set working directory
setwd("~/Data/")

# call for each intersection using the data already prepared using the wrangleAPD.r script.
apd_wordcloud("burnet_anderson.csv", "burnet_anderson.svg")
apd_wordcloud("guadalupe_mlk.csv", "guadalupe_mlk.svg")
apd_wordcloud("lamar_bartonsprings.csv", "lamar_bartonsprings.svg")
apd_wordcloud("riverside_pleasantvalley.csv","riverside_pleasantvalley.svg")
apd_wordcloud("rundberg_lamar.csv", "rundberg_lamar.svg")

#  This line causes an error since there's no data
#apd_wordcloud("fm969_sh130.csv", "fm969_sh130.svg")


# call for all Austin, this one takes a clouple of minutes
apd_wordcloud("APD_Incident_Extract_YTD.csv", "APD_Incident_Extract_YTD.svg")
