#  The library (stringr) is needed for the str_extract function.
#  If you have not already done so, you will need to install via: 
#  install.packages("stringr")

library(stringr)

#set working directory and load csv file
setwd('~/Data/')

# https://data.austintexas.gov/Neighborhood/Affordable-Housing-Inventory/32y8-3gbr
d<-read.csv('Affordable_Housing_Inventory.csv')


#  Remove unecessary columns

d$Contract.ID.. <- NULL
d$Name <- NULL
d$Developer.Owner <- NULL
d$Unit.Type <- NULL
d$Development.Program <- NULL
d$Council.District <- NULL
d$Contact.Phone.Number <- NULL
d$Contact.E.mail <- NULL
d$Total.Units <- NULL
d$Status <- NULL
d$Affordability.Period.Start.Date <- NULL
d$Affordability.Period.Start.Year <- NULL
d$Affordabilty.Period <- NULL
d$Affordability.Period.Expiration.Date <- NULL
d$Units.at.30..MFI <- NULL
d$Units.at.40..MFI <- NULL
d$Units.at.50..MFI <- NULL
d$Units.at.50..MFI <- NULL
d$Units.at.60..MFI <- NULL
d$Units.at.65..MFI <- NULL
d$Units.at.80..MFI <- NULL
d$Market.Rate.Units <- NULL
d$City.Funding.Amount <- NULL
d$Approx....of.Funds.Leveraged <- NULL

#  Here, I use the str_extract fuction and the Location.1 column to extract the GPS coordinates.
#  gsub works like a find replace to remove '(' and ','
#  the parenthese need to be escaped twice

d$longitude<-gsub(",","",gsub("\\(", "", str_extract(d$Location.1, "\\(.*,")))
d$latitude<-gsub(", ", "", gsub("\\)", "", str_extract(d$Location.1, ",.*\\)")))

# write file in the ~/Data directory 
write.csv(d, file="Minified_Affordable_Housing_Inventory.csv", row.names = F)



