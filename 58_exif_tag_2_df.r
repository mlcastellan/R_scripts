setwd("C:/Users/mm/Documents/005_EXIFF_tools/001_TEST_DATA")
path="C:/Users/mm/Documents/005_EXIFF_tools/001_TEST_DATA"
##########################################
##########################################
## esta funcion extrae los              ##
## los datos EXIF de una lista          ##
## de imagenes en una carpeta y         ##
## devuelve un dataframe con los datos  ##
##########################################
##########################################
## input: path donde estan las imagenes ##
## y el formato de imagenes a buscar    ##
## output: dataframe con EXIF data      ##
##########################################
exif_2_df=function(path,format=".jpg"){
##------##
library(exifr)
library(raster)
##------##
img_list=list.files(path=path,pattern=format,ignore.case=T,full.names=T)
##------##
exif_data=read_exif(path=img_list, tags = NULL, recursive = FALSE, args = NULL,quiet = TRUE)
##------##
return(exif_data)
##------##
}
##########################################
#### FIN DE LA FUNCION             #######
##########################################

