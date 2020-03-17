file=file.choose()
shape_01=readOGR(file)
crs(shape_01)
proj4string(shape_01)=CRS("+init=epsg:32719")
writeOGR(shape_01,dsn=".",layer=str_replace_all(basename(file),".shp",""), driver = "ESRI Shapefile",overwrite=T)

