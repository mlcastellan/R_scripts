igrad = focal(r4, matrix(c(-1/2,0,1/2),ncol=3))
jgrad = focal(r4, matrix(c(-1/2,0,1/2),nrow=3))
grad=sqrt((igrad^2)+(jgrad^2))
###################################################
# this script calculates a raster layer gradient ##
######################################
#input: path to raster,
#output: raster gradient
##------
##------
r_path=file.choose()
##------
raster_gradient=function(r_path){
##------
library(raster)
##------
raster_in=raster(r_path)
##------ 
raster_out=raster_in
##------ 
igrad = focal(raster_out, matrix(c(-1/2,0,1/2),ncol=3))
jgrad = focal(raster_out, matrix(c(-1/2,0,1/2),nrow=3))
grad=sqrt((igrad^2)+(jgrad^2))
##------ work with paths
r_out=tools::file_path_sans_ext(basename(r_path))
r_out=paste(tools::file_path_sans_ext(basename(r_path)),"_gradient.tif",sep="")
r_out=file.path(dirname(r_path),r_out)
#------- Export raster as tif
writeRaster(grad,filename=r_out,format="GTiff",overwrite=TRUE,options=c('TFW=YES'))
#------- option to return raster as argument
return(r_out)
#------- final cleanup
rm(c(raster_in,raster_out))
gc()
}
  
}
######################################
### end of the script             ####
######################################
