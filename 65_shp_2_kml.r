#####################################
## Esta funcion lee un shapefile  ###
## y lo exporta como un KML para  ###
## abrirlo en Google Earth o      ###
## similares                      ###
#####################################
#####################################
## input:  path de shapefile      ##
##output: archivo  KML            ##
#####################################
#####################################
#shp_dir="C:/Users/mm/Documents/006_PROCESAMIENTO_2019/005_SHAPEFILES"
shp_path="c:/Users/mm/Documents/002_RASTER_TEST_DATA/test_poligons.shp"
###

shp_2_KML=function(shp_path){
## required packages
library(rgdal)
library(plotKML)
library(sp)
library(spatial)
library(stringr)
## shapefile data
#shp_list=list.files(path=shp_dir,pattern=".shp",ignore.case=T,recursive=T,full.names=T)
#KML_name=str_replace_all(shp_list[2],pattern=".shp",replacement=".kml")
## read a shp
#shp_in<-readOGR(shp_list[[2]])
shp_in<-readOGR(shp_path)
## plotKML
shp_dir=dirname(shp_path)
KML_name=tools::file_path_sans_ext(basename(shp_path))
KML_name=paste(KML_name,".kml",sep="")
KML_out=file.path(shp_dir,KML_name)
plotKML(shp_in,file.name=KML_out,open.kml=F,kmz=get("kmz", envir = plotKML.opts))
#####################################
}
#####################################
### FIN DE LA FUNCION         #######
#####################################
#####################################
