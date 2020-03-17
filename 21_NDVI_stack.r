##############################################
##############################################
## funcion para calcular NDVI partiendo de  ##
## un stack con n bandas a seleccionar      ##
## funcion devuelve un raster layer NDVI    ##
##############################################
##############################################
## INPUT: raster n bandas                  ###
## OUTPUT: ndvi raster layer               ###
##############################################
mosaic_in=file.choose()

NDVI_from_stack=function(mosaic_in,R=3,NIR=4,EXPORT="YES"){
library(raster)
library(rgdal)
#############
r_band=raster(mosaic_in,band=R)
nir_band=raster(mosaic_in,band=NIR)
ndvi=(nir_band-r_band)/(nir_band+r_band)
#############
if(EXPORT=="YES"){
#############  
filename=basename(mosaic_in)
ndvi_name=paste("ndvi_",filename,sep="")
file_out=file.path(getwd(),ndvi_name)
#############
writeRaster(ndvi,filename=file_out,format="HFA")
#############
}
##############################################
return(ndvi)
##############################################
}
########FIN DE LA FUNCION#####################
##############################################
