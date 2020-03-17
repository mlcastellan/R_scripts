##############################################
## Este script lee un raster RGB con tres b ##
## lo transforma a escala de grises y luego ## 
## se aplica un detector de ejes            ##
##. se devuelve un raster con los ejes      ##
##############################################
##############################################
## input: raster con 3 bandas, threshold
## output: sobel edge raster
##############################################
library(raster)
library(rgdal)
#library(wvtool)
library(SpatialTools)
library(spatial.tools)
#-------------------------------------------
ras_loc=file.choose()
thr=1
#---
sobel_edge_detector=function(ras_loc,thr=2){
#---
ras_R_band=raster(ras_loc,layer=1)
ras_G_band=raster(ras_loc,layer=2)
ras_B_band=raster(ras_loc,layer=3)
#-------------------------------------------
fun1=function(x,y,z){((0.30*x+0.59*y+0.11*z)/255)}
ras_gray=overlay(ras_R_band,ras_G_band,ras_B_band,fun=fun1,na.rm=T)
#--- saco los valores NA como 0
ras_gray[is.na(ras_gray)]=0
#-------------------------------------------
# define horizontal and vertical Sobel kernel
kernel_h <- matrix(c(1, 2, 1, 0, 0, 0, -1, -2, -1), nrow = 3)
kernel_v <- t(kernel_h)
#-------------------------------------------
module=function(x,y){
mod=sqrt(x^2+y^2)
return(mod)
}
#-------------------------------------------
sfQuickInit(cpus=3)
v_values=focal(ras_gray,w=kernel_h,fun=sum,na.rm=T)
h_values=focal(ras_gray,w=kernel_v,fun=sum,na.rm=T)
s_values=overlay(v_values,h_values,fun=module,na.rm=T)
sfQuickStop()
#------------------------------------------
#pruebo un threshold sobre los edges detectados antes
values(s_values)[values(s_values)<=thr]=NA
#-------------------------------------------
return(s_values)
###-------
r_out=tools::file_path_sans_ext(ras_loc)
r_out=paste(r_out,"_sobel.img",sep="")
writeRaster(s_values,filename=r_out,format="HFA",overwrite=T)
gc()
#-------------------------------------------
}
#-------------------------------------------
