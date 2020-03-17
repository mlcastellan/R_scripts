library(raster)
library(beepr)
###################
ras_folder="c:/Users/mm/Documents/009_INTERFILADO & RELLENO R/2019_solfrut_alta-res/solfrut_2019_ndvi_tiles_noclump/"
setwd(ras_folder)
merge_list=list.files(path=ras_folder,pattern=".img$",full.names=T,ignore.case=T)
raster_list=list()

for(i in 1:length(merge_list)){raster_list[[i]]=raster(merge_list[i])}


raster_list$filename <- 'merged.IMG'
raster_list$overwrite <- TRUE
raster_list$format <-"HFA"
m <- do.call(merge, raster_list)
beep()
#_m_2 <- focal(m,w=matrix(1,1,3),fun=median,na.rm=T,NAonly=T)
beep()
writeRaster(m,filename="test.img",format="HFA",overwrite=T)
beep()
