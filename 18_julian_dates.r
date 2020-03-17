library(chron)
lista_files=list.files("C:/Users/MC1988/Google Drive/PROFESIONALES-ACADEMICOS/AGRISAT/20180917_cuESTARFM/007_testVM/TEST_03/MODIS_R",pattern=".tif",full.names = TRUE)
setwd("C:/Users/MC1988/Google Drive/PROFESIONALES-ACADEMICOS/AGRISAT/20180917_cuESTARFM/007_testVM/TEST_03/MODIS_R")

julian_day=75

origin.=as.numeric(c(month = 12, day = 31, year = 2015))
date=month.day.year(julian_day, origin.)
month=str_pad(date$month, 2, pad = "0")
day=str_pad(date$day, 2, pad = "0")
print(paste(date$year," ",date$month," ",date$day))
