###
library(sp)
library(rgdal)
library(stringr)
##
santander_locs=file.choose()
##
bike_docs=readOGR(santander_locs)
##
zone_id=as.vector(unique(bike_docs@data$Borough))
##
i=13
#for(i in length(zone_id)){
  
zonal_shp=bike_docs[bike_docs$Borough==zone_id[i],]
##
name=str_replace_all(paste("santander_bike_zone_",zone_id[i],".kml"),pattern=" ",replacement="")
name_2=tools::file_path_sans_ext(name)
##
writeOGR(zonal_shp,dsn=name,layer=name_2,driver="KML")   
print(i)
}
