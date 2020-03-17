list_of_shp=list.files(path="E:",pattern=".shp$",ignore.case=TRUE,full.names = T)
for(i in 1:length(list_of_shp)){
  fileName=basename(list_of_shp[[i]])
  fileName=str_replace(fileName,pattern=".shp",replacement = "")
  fileName=str_replace(fileName,pattern="E:",replacement = "")
  
  ###-------------------------------------------
  shape_01=readOGR(list_of_shp[i])
  ## por las dudas lo reprojecto a lon lat que es lo estandar
  shape_01=spTransform(shape_01,CRS("+init=epsg:4326"))
  
  ##---agrego datos al shapefile si no los tiene
  shape_01$Empresa<-"CHANDON"
  writeOGR(shape_01, dsn=list_of_shp[[i]],layer=fileName, driver = "ESRI Shapefile",overwrite=T)
  
  
  
  
}
