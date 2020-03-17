rm(list=ls())
getwd()
setwd("/home/martin-r")
#-------------------------------------------
library(raster)
library(rgdal)
#------------------------------------------
#image <- stack(file.choose())
image <- raster(file.choose())
#image <- clip(image,subset)
#-------------------------------------------
summary(image)
img_crs=crs(image)
crs(image)
#-------------------------------------------
###classify raster
image.df <- as.data.frame(image)  
cluster.image <- kmeans(na.omit(image.df), 3, iter.max = 50, nstart = 25) ### kmeans, with 10 clusters
#add back NAs using the NAs in band 1 (identic NA positions in all bands), see http://stackoverflow.com/questions/12006366/add-back-nas-after-removing-them/12006502#12006502
image.df.factor <- rep(NA, length(image.df[,1]))
image.df.factor[!is.na(image.df[,1])] <- cluster.image$cluster
#create raster output
clusters <- raster(image)   ## create an empty raster with same extent than "image"  
clusters <- setValues(clusters, image.df.factor) ## fill the empty raster with the class results  
plot(clusters)

#-------------------------------------------
#proj4string(clusters)=CRS(img_crs)
writeRaster(clusters,format='GTiff',filename="raster_kmeans.tif",overwrite=T)
