#########################################
## script to create kml layer 
## from csv file of bike dock locations
## in london
#########################################
#input: csv file
#output: kml file with locations
#########################################
csv_file=file.choose()
#########################################
df=read.csv(csv_file,header=T,sep=";")
#########################################
library(tidyverse)
library(sf)
library(sp)
library(rgdal)
library(raster)
#########################################
coordinates(df) <- ~ Coords.Easting + Coords.Northing
proj4string(df)=CRS("+init=epsg:27700")
df=spTransform(df,CRS("+init=epsg:4326"))
#########################################
writeOGR(df,"spatial_layer.kml",layer="layer", driver="KML") 
#########################################
