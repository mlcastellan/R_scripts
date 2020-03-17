S73_clip_raster_2_extent=function(r1,r2){
  ##
  library(raster)
  library(sp)
  library(rgdal)
  ##
  ### reprojecto el r2 al crs del r1
  r2=projectRaster(r2,proj4string(r1))
  r1_extent=extent(r1)
  r1_extent=as(r1_extent,'SpatialPolygons')
  proj4string(r1_extent)=proj4string(r1)
  ## recorto el raster al extent del raster
  r2_crop <- crop(r1,r1_extent,snap='in') 
  ## enmascaro el raster para solo tener los valores dentro del shapefile
  r2_crop <- mask(r2_crop,r1_extent)
  ##
  return(r2_crop)
  
}