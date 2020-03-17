MODIS_folder="C:/Users/MC1988/Desktop/Rasters/MODIS/REPROJECTED"
NDVI_folder="C:/Users/MC1988/Desktop/Rasters/"

library(tools)
library(raster)
library(stringr)
library(chron)

setwd("C:/Users/MC1988/Desktop/Mendoza_cuESTARFM/Rasters/LANDSAT")


R_folder="LANDSAT_R"
NIR_folder="LANDSAT_NIR"


lista_R=list.files(R_folder,pattern=".tif",full.names=F,ignore.case=T)
lista_NIR=list.files(NIR_folder,pattern=".tif",full.names=F,ignore.case=T)

for(i in 1:length(lista_R)){
  setwd("C:/Users/MC1988/Desktop/Mendoza_cuESTARFM/Rasters/LANDSAT/LANDSAT_R")
  ano=substr(lista_R[i],18,21)
  mes=substr(lista_R[i],22,23)
  dia=substr(lista_R[i],24,25)
  R_name=paste("L_",ano,"_",mes,"_",dia,"_R.tif",sep="")
  file.rename(lista_R[i],R_name)
}
for(i in 1:length(lista_NIR)){
  setwd("C:/Users/MC1988/Desktop/Mendoza_cuESTARFM/Rasters/LANDSAT/LANDSAT_NIR")
  ano=substr(lista_NIR[i],18,21)
  mes=substr(lista_NIR[i],22,23)
  dia=substr(lista_NIR[i],24,25)
  NIR_name=paste("L_",ano,"_",mes,"_",dia,"_NIR.tif",sep="")
  file.rename(lista_NIR[i],NIR_name)
}


setwd("C:/Users/MC1988/Desktop/Mendoza_cuESTARFM/Rasters/MODIS")


R_folder="MODIS_B1"
NIR_folder="MODIS_B2"


lista_R=list.files(R_folder,pattern=".tif",full.names=F,ignore.case=T)
lista_NIR=list.files(NIR_folder,pattern=".tif",full.names=F,ignore.case=T)



for(i in 1:length(lista_R)){
  #setwd("MODIS_B1")
  #Extraigo la fecha en formato de modis original 2015325
  date=gsub(".*[_doy]([^.]+)[_].*", "\\1", lista_R[i])
  #agrego el a?o a una columna del dataframe
  ano=as.numeric(substr(date, start = 1, stop = 4))
  #-transformo los dias julianos en mes y dia para cada a?o
  julian_day=as.numeric(substr(date, start = 5, stop = 7))  
  origin.=as.numeric(c(month = 1, day = 1, year = ano))
  date=month.day.year(julian_day, origin.)
  month=str_pad(date$month, 2, pad = "0")
  day=str_pad(date$day, 2, pad = "0")
  #genero una columna del df con el formato de nombre que necesita cuESTARFM
  nombre=paste("M_",date$year,"_",month,"_",day,"_R",".tif",sep="")
  file.rename(lista_R[i],nombre)
  
}

for(i in 1:length(lista_NIR)){
  #setwd("C:/Users/MC1988/Desktop/Mendoza_cuESTARFM/Rasters/MODIS/MODIS_B2")
  #Extraigo la fecha en formato de modis original 2015325
  date=gsub(".*[_doy]([^.]+)[_].*", "\\1", lista_NIR[i])
  #agrego el a?o a una columna del dataframe
  ano=as.numeric(substr(date, start = 1, stop = 4))
  #-transformo los dias julianos en mes y dia para cada a?o
  julian_day=as.numeric(substr(date, start = 5, stop = 7))  
  origin.=as.numeric(c(month = 1, day = 1, year = ano))
  date=month.day.year(julian_day, origin.)
  month=str_pad(date$month, 2, pad = "0")
  day=str_pad(date$day, 2, pad = "0")
  #genero una columna del df con el formato de nombre que necesita cuESTARFM
  nombre=paste("M_",date$year,"_",month,"_",day,"_NIR",".tif",sep="")
  file.rename(lista_NIR[i],nombre)
  
}
