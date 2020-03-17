#######################################
#######################################
## este script rellena el inter    ####
## filado de un raster en funcion  ####
## de la mediana y de la resolucion####
## del raster                      ####
#######################################
#######################################
## input: raster
## output: raster desinterf y rellenado
#######################################
#######################################
ras_folder="/home/martin-r/05_Rasters/009_INTERFILADO_RELLENO_R/bianchi_01/"
interlineado=2.00
#######################################
desinterfilado_relleno(ras_folder=ras_folder,interlineado=2.00,format="img")
#######################################
desinterfilado_relleno=function(ras_folder,format,interlineado=2.00){
#######################################
  library(raster)
  library(rgdal)
  library(stringr) 
  library(parallel)
  library(beepr)
  library(ClusterR)
###-------
setwd(ras_folder)
directoryExists("FILL")
###-------
ras_list=list.files(path=ras_folder,pattern=format,ignore.case=T,full.names=T)
#######################################
#start_time=str_split(Sys.time(),pattern=" ")[[1]][2]
#######################################
# Calculate the number of cores
no_cores <- detectCores()
# Initiate cluster
#######################################
###-------
for(i in 1:length(ras_list)){
### inicio el cluster
beginCluster(no_cores, type='SOCK')
r1=raster(ras_list[[i]])
### uso un kernel de un ancho entre filas+2 pixels
res=as.numeric(str_split(res(r1),pattern=" ",n=1)[[1]])
n=(interlineado%/%res)

kernel=matrix(1,n,n)
###-------
r1[r1<=0]=NA
### calculo de la mediana del raster desinterfilaado
r2=focal(r1,w=kernel,fun=median,pad=T,padValue=NA,na.rm=T)
endCluster()
### agregue este threshold para bajar el limite de la mediana
#values(r2)=0.75*values(r2)
#####################################################
#### Filtro el raster con la mediana ################
#####################################################
#####################################################
#x es r1
#y es el raster mediana
overlay_stack=stack(r1,r2)
f1=function(x){ifelse(x[[1]]>=x[[2]],x[[1]],NA)}
#################
#overlay_stack,overlay,(r1,r2,fun=f1)
beginCluster(no_cores, type='SOCK')
r3=clusterR(overlay_stack,overlay, args=list(fun=f1))
endCluster()
#################
beginCluster(no_cores,type="SOCK")
r4=clusterR(r3,distance)### raster de distancia de NA a pixel mas cercano
endCluster()
#####################################################
#####################################################
#### paso de rellenar el raster desinterfilado#######
#####################################################
##################################
fun_1=function(x,y){
  #################
  ####x es raster
  ####y es distancia a pixel
  a=min(y)
  n=which(y %in% a)
  #################
  new_value=mean(x[n])
  #################
  x=new_value
  #################
  #################
}
#################
##################################
gc()
r5=raster::localFun(r3,r4,ngb=3,fun=fun_1,NAonly=TRUE)
r5=raster::localFun(r5,r4,ngb=3,fun=fun_1,NAonly=TRUE)
r5=raster::localFun(r5,r4,ngb=5,fun=fun_1,NAonly=TRUE)
#################
###-------
r5_out=tools::file_path_sans_ext(basename(ras_list[[i]]))
r5_out=paste(r5_out,"_fill.img",sep="")
r5_out=file.path("FILL",r5_out)
writeRaster(r5,filename=r5_out,format="HFA",overwrite=T)
print(i)
gc()
#######################################
#end_time=str_split(Sys.time(),pattern=" ")[[1]][2]
#processing_time=start_time-end_time
#msg=paste("tile :",i," processing time: ",processing_time)
#print(msg)
#######################################
endCluster()
#######################################
System("sudo shutdown -h now")
#######################################
}
#######################################
}
#######################################









#######################################
#######################################
###---FUNCIONES
directoryExists<-function(directory) {
  # check to see if there is a processing folder in workingDirectory 
  # and check that it is clear.
  if(dir.exists(directory)){
    message(paste("Nothing to do,",directory," exists"))
  }else{
    # if not the case, create it.
    
    dir.create(directory,recursive=TRUE)
  }
}
#######################################
#######################################
