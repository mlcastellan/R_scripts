library(SpaDES)
library(raster)
library(beepr)
setwd("c:/Users/mm/Documents/009_INTERFILADO & RELLENO R/2019_solfrut_alta-res")
ras_loc=file.choose()
raster=raster(ras_loc)
res(raster)



raster[raster==0]=NA



raster[!is.finite(raster)] <- 0

beep(3)
              
splitRaster(raster, nx=10, ny=10,rType = "FLT4S",path ="solfrut_2019_ndvi_tiles/")
beep(3)

#raster_grid=raster(file.choose())
### relleno las lineas de union de los tiles
raster=raster(file.choose())
raster=raster::focal(raster,w=kernel,fun=mean,na.only=T,na.rm=T)
writeRaster(raster,filename=ras_loc,format="HFA",overwrite=T)
gc()
