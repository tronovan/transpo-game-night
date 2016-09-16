# Here I have the 311_Unified_Data.csv file in a folder called ~/Data/
# https://data.austintexas.gov/Public-Safety/APD-Incident-Extract-YTD/b4y9-5x39
setwd("~/Data/")
d<-read.csv('APD_Incident_Extract_YTD.csv')

#  Here I'm getting rid of a bunch of columns since we're not using them.

d$Date<-NULL
d$Time<-NULL
d$Location.1<-NULL
d$LOCATION_TYPE<-NULL

#  Wrangle funtion
wrangleAPD<- function(street1, street2, filename){
  #make subset based on first street
  i<-grepl(paste(".*", street1, ".*", sep=""), d$ADDRESS, ignore.case=T)
  sub<-d[i,]
  
  #make second subset based on second street
  i2<-grepl(paste(".*", street2, ".*", sep=""), sub$ADDRESS, ignore.case=T)
  sub2<-sub[i2,]
  
  # write RAW data
  write.csv(sub2, file=filename, row.names = F)
  
  # make table and write stats data
  write.csv(sort(table(sub2$Crime.Type), decreasing = T), paste("APDStat_",filename, sep=""), row.names = F)
}


#  Call function for each intersection
#  arguments are first street, cross street, filename
wrangleAPD("rundberg", "lamar", "rundberg_lamar.csv")
wrangleAPD("airport", "e.51", "airport_51.csv")
wrangleAPD("burnet", "anderson", "burnet_anderson.csv")
wrangleAPD("fm.969", "sh.130", "fm969_sh130.csv")
wrangleAPD("riverside", "pleasant.valley", "riverside_pleasantvalley.csv")
wrangleAPD("lamar", "barton.springs", "lamar_bartonsprings.csv")
# here I use '|' or to search mlk or martin luther king
wrangleAPD("guadalupe", "mlk|martin.luther.king", "guadalupe_mlk.csv")
