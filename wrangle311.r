# Dataset URL
# https://data.austintexas.gov/Government/311-Unified-Data/i26j-ai4z

# Here I have the 311_Unified_Data.csv file in a folder called ~/Data/
#  set working directory and read csv

setwd("~/Data/")
d<-read.csv('311_Unified_Data.csv')

#  Here I'm getting rid of a bunch of columns since we're not using them.

d$Owning.Department<-NULL
d$Status.Change.Date<-NULL
d$Close.Date<-NULL
d$Street.Name<-NULL
d$County<-NULL
d$Council.District<-NULL
d$SR.Type.Code<-NULL
d$Method.Received<-NULL
d$City<-NULL
d$State.Plane.X.Coordinate<-NULL
d$State.Plane.Y.Coordinate<-NULL
d$SR.Status<-NULL
d$Last.Update.Date<-NULL
d$Street.Number<-NULL
d$Zip.Code<-NULL
d$Map.Page<-NULL
d$Map.Tile<-NULL
d$Created.Date<-NULL
d$X.Latitude.Longitude.<-NULL

#  Wrangle funtion
wrangle311<- function(street1, street2, filename){
  #make subset based on first street
  i<-grepl(paste(".*", street1, ".*", sep=""), d$SR.Location, ignore.case=T)
  sub<-d[i,]
  
  #make second subset based on second street
  i2<-grepl(paste(".*", street2, ".*", sep=""), sub$SR.Location, ignore.case=T)
  sub2<-sub[i2,]
  
  # write RAW data
  write.csv(sub2, file=filename, row.names = F)
  
  # make table and write stats data
  write.csv(sort(table(sub2$SR.Description), decreasing = T), paste("311Stat_",filename, sep=""), row.names = F)
}


#  Call function for each intersection
#  arguments are first street, cross street, filename
wrangle311("rundberg", "lamar", "rundberg_lamar.csv")
wrangle311("airport", "e.51", "airport_51.csv")
wrangle311("burnet", "anderson", "burnet_anderson.csv")
wrangle311("fm.969", "sh.130", "fm969_sh130.csv")
wrangle311("riverside", "pleasant.valley", "riverside_pleasantvalley.csv")
wrangle311("lamar", "barton.springs", "lamar_bartonsprings.csv")
# here I use '|' or to search mlk or martin luther king
wrangle311("guadalupe", "mlk|martin.luther.king", "guadalupe_mlk.csv")
