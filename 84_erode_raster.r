######################################
# this script performs and erosion  ##
# operation on a raster and writes  ##
# the eroded raster                 ##
######################################
#input: path to raster,
#erosion kernel   n=matrix rows, m=matrix cols, val= matrix values
#output: eroded raster
##------
r_path=file.choose()
##------
erode_raster=function(n=3,m=3,val=1,r_path=r_path){
  library(mmand)
  library(raster)
  ##------
  kernel=matrix(n,m,1)
  ##------
  raster_in=brick(r_path)
  raster_vals=as.matrix(raster_in)
  ##------ here the magic happens
  raster_out=raster_in
  raster_er=erode(raster_vals,kernel)
  rm(raster_vals)
  raster_out<- setValues(raster_out, raster_er)
  ##------ work with paths
  r_out=tools::file_path_sans_ext(basename(r_path))
  r_out=paste(tools::file_path_sans_ext(basename(r_path)),"_eroded.tif",sep="")
  r_out=file.path(dirname(r_path),r_out)
  #------- Export raster as tif
  writeRaster(raster_out,filename=r_out,format="GTiff",overwrite=TRUE)
  #------- option to return raster as argument
  return(r_out)
  #------- final cleanup
  rm(c(raster_in,raster_out))
  gc()
}
######################################
##EOS END OD SCRIPT                  #
######################################
######################################
