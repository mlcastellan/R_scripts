##################################
##################################
### este script lee los datos  ###
### de un shapefile y genera
### los coef de la reg lineal
### para el GO
##################################
##################################
library(raster)
library(rgdal)
library(stringr)
##################################
dir="h:/031_bianchI/GO_031_bianchi/"
##################################
file_loc=list.files(path=dir,pattern=".dbf",full.names=T,ignore.case=T)
##################################
shp=readOGR(file_loc)
##################################
y=shp$REF
x=shp$TO_CAL
values=data.frame(x,y)
##################################
linear_model=lm(y ~ x, values)
int=as.numeric(linear_model$coefficients[1])
slope=as.numeric(linear_model$coefficients[2])##bx
plot(values$y,values$x)
##################################
r1_name=file.choose()
r1=raster(r1_name)
values(r1)=int+slope*values(r1)
##################################
r1_out=tools::file_path_sans_ext(basename(r1_name))
r1_out=paste(r1_out,"_GO",sep="")
writeRaster(r1,filename=r1_out,format="HFA",overwrite=T)
