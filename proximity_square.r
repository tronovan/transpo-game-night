# set working directory
setwd('~/Data2/')

# THis sets how many decimal points get printed.
# This is needed so gps coords don't get rounded 
options(digits=10)

# read in the already minified affordable housing data
# This file should already have created using the affordable_minify.r script.

a<-read.csv('Minified_Affordable_Housing_Inventory.csv')

# remove rows which do not have longitude
a<-a[!is.na(a$longitude),]


#  proximity square function
#  this function takes the longitude and latitude plus spread
#  spread is how big you want to make the square.  

proximity_square<-function(xlongitude, ylatitude, spread){
  
  #  Here, I'm making subsets based on the long, lat, and spread
  b<-a[a$longitude < xlongitude + spread,]
  b<-b[b$longitude > xlongitude - spread,]
  
  b<-b[b$latitude < ylatitude + spread,]
  b<-b[b$latitude > ylatitude - spread,]
  
  # I return the resulting dataset
  return(b)
}




# this sets the spread 
# a smaller number is a smaller proximity square
s<-0.05

# call the proximity_square function for each intersection
#  pass long, lat, and 's' (spread) for each intersection
#  write the files in working directory
write.csv(proximity_square(30.13936343,-97.77151173, s), file="affordable_rundberg_lamar.csv", row.names = F)
write.csv(proximity_square(30.31206778,-97.71534628, s), file="affordable_airport_51.csv", row.names = F)
write.csv(proximity_square(30.35615096,-97.73090442, s), file="affordable_burnet_anderson.csv", row.names = F)
write.csv(proximity_square(30.28172985,-97.74192973, s), file="affordable_guadalupe_mlk.csv", row.names = F)
write.csv(proximity_square(30.26085944,-97.7585309, s), file="affordable_lamar_bartonsprings.csv", row.names = F)
write.csv(proximity_square(30.23367751,-97.7234957, s), file="affordable_riverside_pleasantvalley.csv", row.names = F)
write.csv(proximity_square(30.25341885,-97.60359279, s), file="affordable_fm969_sh130.csv", row.names = F)

