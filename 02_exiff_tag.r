rm(list=ls())
getwd()
setwd("C:/Users/mm/Documents/005_EXIFF_tools/001_TEST_DATA")
#-------------------------------------------
##filename_exif=file.choose()
##ras=brick(filename_exif)
##lat_exif=41.40338
##lon_exif=02.17403
#----------------agrego coordenadas gps
#exiftool_cmd <- paste("exiftool -GPSLongitudeRef=W -GPSLongitude=",lon_exif," -GPSLatitudeRef=S -GPSLatitude=",lat_exif," ",filename_exif,sep='')
#system(exiftool_cmd)
#----------------leo para ver si se modificaron las coordenadas
#---
extract_exif=function(image_filename){
  #-------------------------------------------
  library(raster)
  library(rgdal)
  library(stringr)
  #-------------------------------------------
  if(dir.exists("EXIF")==FALSE){dir.create("EXIF")}
  #-------------------------------------------
  if(str_detect(toupper(image_filename),pattern=".JPG")){
  filename_txt=basename(str_replace(image_filename,pattern=".JPG",replacement=".txt"))
  }
  if(str_detect(toupper(image_filename),pattern=".TIF")){
    filename_txt=basename(str_replace(image_filename,pattern=".TIF",replacement=".txt"))
  }
  #-------------------------------------------
  read_exif_command=paste("exiftool",image_filename)
  exif_data=system(read_exif_command,intern=TRUE)
  #-------------------------------------------
  filename_txt=file.path("EXIF",basename(filename_txt))
  
  fileConn<-file(filename_txt)
  writeLines(exif_data, fileConn)
  close(fileConn)
  
  
  }


image_folder="C:/Users/mm/Documents/005_EXIFF_tools/001_TEST_DATA/NO_GPS/"
image_list=list.files(path=image_folder,full.names=TRUE)
for(i in 1:length(image_list)){
  extract_exif(image_list[[i]])
  #print(i," de ",length(image_list))
  
}
