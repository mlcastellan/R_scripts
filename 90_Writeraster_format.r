#################################################
## script to retrieve raster                   ##
## to define output format in writeRaster      ##
#################################################
## input: raster_path                          ##
## output: format as req by writeRaster function#
#################################################
r_path=file.choose()
raster_format=function(r_path){
  library(raster)
  F_type=c("raster","ascii","SAGA","IDRISI","CDF","GTiff","ENVI","EHdr","HFA")
  ext=c("grd","asc","sdat","rst","nc","tif","envi","bil","img")
  F_ext=tools::file_ext(r_path)
  index=which(ext%in%F_ext)
  Format=F_type[index]
  #################################################
  return(Format)
}
#################################################
### script end                                ###
#################################################
