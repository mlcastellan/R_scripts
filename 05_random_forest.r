rm(list=ls())
getwd()
setwd("/home/martin-r")
#--------------------------------------------
library(rgdal)
library(raster)
library(reshape2)
library(caret)
#--------------------------------------------
img=brick(file.choose())
summary(img)
crs(img)
names(img) <- paste0("B", c(1:3, 4)) 
names(img)
writeRaster(img,format='GTiff',filename="img.tif",overwrite=T)
#------------- pruebo un plot--------------
#plotRGB(img*(img >= 0),r=4,g=5,b=3,scale =10000)
trainData=shapefile(file.choose())
responseCol="class"
#extraigo los valores de cada pixel y en cada banda para las areas de entrenamiento
dfAll = data.frame(matrix(vector(), nrow = 0, ncol = length(names(img)) + 1))   
for (i in 1:length(unique(trainData[[responseCol]]))){
  category <- unique(trainData[[responseCol]])[i]
  categorymap <- trainData[trainData[[responseCol]] == category,]
  dataSet <- extract(img, categorymap)
  if(is(trainData, "SpatialPointsDataFrame")){
    dataSet <- cbind(dataSet, class = as.numeric(rep(category, nrow(dataSet))))
    dfAll <- rbind(dfAll, dataSet[complete.cases(dataSet),])
  }
  if(is(trainData, "SpatialPolygonsDataFrame")){
    dataSet <- dataSet[!unlist(lapply(dataSet, is.null))]
    dataSet <- lapply(dataSet, function(x){cbind(x, class = as.numeric(rep(category, nrow(x))))})
    df <- do.call("rbind", dataSet)
    dfAll <- rbind(dfAll, df)
  }
}
# Entreno el modelo con los recortes del shapefile del paso anterior metodo random forest(dendritico)
nsamples <- 10000
sdfAll <- dfAll[sample(1:nrow(dfAll), nsamples), ]
#-----------------------------------------------------------------------------
modFit_rf=train(as.factor(class) ~ B1 + B2 + B3 + B4, method = "rf", data = sdfAll)
#configurar el calculo con varios cores--y realizar la prediccion en el raster
beginCluster()
preds_rf <- clusterR(img, raster::predict, args = list(model = modFit_rf))
endCluster()
#---------exporto la clasificacion como raster--------------------
writeRaster(preds_rf,format='GTiff',filename="preds_rf.tif",overwrite=T)
#trabajo con el valor enmascarado
masked_out=mask(preds_rf,preds_rf,maskvalue=1,updatevalue=0,inverse=T)
img=overlay(img,masked_out,fun=function(x,y){x*y})
writeRaster(preds_rf,format='GTiff',filename="preds_rf.tif",overwrite=T)
