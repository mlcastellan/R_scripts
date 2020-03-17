##########################################
### esta funcion transforma           ####
### una img jpg en geotiff            ####
### y le asigna el crs epsg:4326      ####
##########################################
#raster_loc=file.choose()
##########################################
jpg_2_gtif=function(raster_loc){
###------######
library(raster)
###------######
raster=stack(raster_loc)
#plot(raster)
###------###### asigno el crs epsg:4326 al raster
projection(raster)=CRS("+init=epsg:4326")
crs(raster)
###----- exporto como geotif
writeRaster(raster,filename=basename(raster_loc),format="GTiff",overwrite=TRUE)
###----- devuelvo el raster como variable
return(raster)     
}
###### FIN DE LA FUNCION  ################
            