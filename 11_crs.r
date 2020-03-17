
#----------------------SEGUIR DESDE ACA ---------------------


###########################################
## esta funcion le asigna un CRS a una  ###
## lista de rasters en un cierto formato###
###########################################
## input: raster directory,formato,epsg  ##
## output: rasters con crs asignado      ##
###########################################
###########################################
ras_dir="C:/Users/mm/Documents/006_PROCESAMIENTO_2019/Bodegas_2019/Mosaicos_bgrnir/"
epsg="32719"
format=".img"
out_dir="003_MOSAIC_EPSG_BGRNIR_TIF/"
###########################################
assig_crs_2_raster(ras_dir=ras_dir,format=format,epsg=epsg,out_dir=out_dir)
###########################################
###########################################
  
assig_crs_2_raster=function(ras_dir,format=".img",epsg,out_dir){
###########################################
library(raster)
library(rgdal)
library(gdalUtils)
library(tools)
library(rgeos)
library(sp)
library(stringr)
###########################################
directoryExists(out_dir)
###########################################
  
  
epsg=paste("+init=epsg:",epsg,sep="")
###----##
stack_list=list.files(path=ras_dir,pattern=format,ignore.case=T,full.names=T)
stack_out=file.path(out_dir,str_replace_all(basename(stack_list),pattern=format,replacement=".tif"))
###----##
for(i in 1:length(stack_list)){
  
  ras=stack(stack_list[[i]])
  projection(ras)=CRS(epsg)
  writeRaster(ras,filename=stack_out[[i]],format="GTiff",options=c('TFW=YES'),overwrite=T)
  ###----##
  print(i)
  ###----##
  
  }
###----##
###########################################
}
#### FIN DE LA FUNCION       ##############
###########################################

##############################
### FUNCIONES           ######
##############################

directoryExists<-function(directory) {
  # check to see if there is a processing folder in workingDirectory 
  # and check that it is clear.
  if(dir.exists(directory)){
    message(paste("Nothing to do,",directory," exists"))
  }else{
    # if not the case, create it.
    
    dir.create(directory,recursive=TRUE)
  }
}

