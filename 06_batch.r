rm(list=ls())
getwd()
setwd("/home/martin-r/03_projects/S08_batch/")
#-----------------------
library(raster)
library(rgdal)
library(OpenImageR)
#----------------------
path_in = "/home/martin-r/03_projects/S08_batch/img/"
path_out ="/home/martin-r/03_projects/S08_batch/out/"
#dir.create(path_out)
# read files in folder
file_names=list.files(path_in,pattern="\\.jpg$",full.names = T)
# change extensions
extension(file_names) <- 'jpg'
#----------------------
#loop
for(i in 1:length(file_names)) {
  print(i)
  r <-raster(file_names[i])
  #------procesado de prueba, uso un thresholding
  r=as.matrix(r)
  r=image_thresholding(r,thresh=150)
  r=raster(r)
  #----------------------
  #rc <- crop(r, e)
  file_names_out=paste0(path_out,"ras_02_",i,".tif")
  print(file_names_out)
  rc <- writeRaster(r, paste0(path_out,"ras_02_",i),format="GTiff",options=c('TFW=YES'),overwrite=T)
}