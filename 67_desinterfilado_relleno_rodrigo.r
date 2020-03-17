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
ras_folder="C:/Users/mm/Documents/009_INTERFILADO & RELLENO R/SPLIT/LA-COLONIA_TILES"
interlineado=3.00
format="grd"
#######################################
desinterfilado_relleno(ras_folder=ras_folder,interlineado=2.00,format="grd")
#######################################
desinterfilado_relleno=function(ras_folder,format,interlineado=2.00){
#######################################
  library(raster)
  library(rgdal)
  library(stringr) 
  library(parallel)
  library(beepr)
  library(ClusterR)
  library(mmand)
  library(spatial.tools)
###-------
setwd(ras_folder)
directoryExists("FILL")
###-------
ras_list=list.files(path=ras_folder,pattern=format,ignore.case=T,full.names=T)
#######################################
start_time=as.numeric(as.POSIXct(Sys.time()))
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
#n=(interlineado%/%res)
n=9
kernel1=matrix(1,n,n)
###-------
r1[r1<=0]=NA
### calculo de la mediana del raster desinterfilaado
r2=focal(r1,w=kernel1,fun=median,pad=T,padValue=NA,na.rm=T)
r2_max=focal(r1,w=kernel1,fun=max,pad=T,padValue=NA,na.rm=T)
r2_rodrigo=(r2+r2_max)/2.00
endCluster()
#####################################################
#### Filtro el raster con la mediana ################
#####################################################
#####################################################
#x es r1
#y es el raster rodrigo
f1=function(x,y){ifelse(x>=y,x,NA)}
#################
r3_rodrigo=overlay(r1,r2_rodrigo,fun=f1)
#################
#overlay_stack,overlay,(r1,r2,fun=f1)
beginCluster(no_cores,type="SOCK")
#r3=clusterR(overlay_stack,overlay, args=list(fun=f1))
#################
r3_clump_mask=remove_clumps_from_raster(raster_in=r3_rodrigo,n=3)
r3=mask(r3_rodrigo,r3_clump_mask,maskvalue=NA)
#################
endCluster()
#################
beginCluster(no_cores,type="SOCK")
r4=distance(r3)### raster de distancia de NA a pixel mas cercano
endCluster()
#####################################################
#####################################################
#### paso de rellenar el raster desinterfilado   ####
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
beginCluster(no_cores,type="SOCK")
#################
r5=raster::localFun(r3,r4,ngb=3,fun=fun_1,NAonly=TRUE)
r5=raster::localFun(r5,r4,ngb=3,fun=fun_1,NAonly=TRUE)
gc()
r5=raster::localFun(r5,r4,ngb=5,fun=fun_1,NAonly=TRUE)
gc()
r5=raster::localFun(r5,r4,ngb=15,fun=fun_1,NAonly=TRUE)
gc()
#################
r5=raster::focal(r5,w=matrix(1,3,3),fun=mean,na.rm=T)
#################
endCluster()

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
#System("sudo shutdown -h now")
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
###########################################
##### This function removes clumps of  ####
##### pixels of less than n elements   ####
###########################################
###########################################
## INPUT: raster, minimum clump size
## OUTPUT: filtered raster
###########################################
remove_clumps_from_raster=function(raster_in,n=9){
  #####
  library(raster)
  library(dplyr)
  #####
  #³raster_in=raster(raster_loc)
  raster_in=raster_in
  #####
  raster_clumps <- clump(raster_in,gaps=F,directions=8)
  ## Assign freqency table to a matrix
  clumpFreq <- freq(raster_clumps)
  clumpFreq=as.data.frame(clumpFreq)
  ## which rows of the data.frame are only represented by n cells
  str(which(clumpFreq$count<=n))
  ## which values do these correspond to?
  str(clumpFreq$value[which(clumpFreq$count<=n)])
  
  ## Put these into a vector of clump ID's to be removed
  excludeID <- clumpFreq[,1][which(clumpFreq[,2]<=n)]
  ## Make a new forest mask to be sieved
  raster_sieve_mask=raster_clumps
  
  ## Assign NA to all clumps whose IDs are found in excludeID
  raster_sieve_mask[raster_clumps %in% excludeID] <- NA
  ##
  #???writeRaster(raster_sieve_mask,filename="raster_sieve_mask.tif",format="GTiff",overwrite=T)
  
  return(raster_sieve_mask)
  ###########################################
}
###########################################
## End of script               ############
###########################################







