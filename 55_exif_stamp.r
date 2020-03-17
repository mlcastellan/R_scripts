create_Directories_for_process<-function(){
  directoryExists("EXIF_STAMPED")
  #directoryExists("shapefile_csv_1")
  #directoryExists("shapefile_csv_2")

}





#######################################
## Esta funcion estampa los datos de ##
## GPS de lA LISTA EXIF_GPS en las   ##
## imagenes que no cuentn con datos  ##
## EXIF de GPS                       ##
#######################################
## INPUT: lista de imagenes con gps, ##
## lista de imagenes sin gps         ##
## OUTPUT: imagenes con geotag       ##
#######################################
GPS_dir_1="C:/Users/mm/Documents/005_EXIFF_tools/Solfrut/RGB_ALL/"
NO_GPS_dir_1="C:/Users/mm/Documents/005_EXIFF_tools/Solfrut/NIR_ALL/"
#######################################
setwd("C:/Users/mm/Documents/005_EXIFF_tools/Solfrut/")


exif_gps_stamp=function(GPS_dir=GPS_dir_1,NO_GPS_dir=NO_GPS_dir_1,format=".JPG"){
####------------------------------------
library(stringr)
library(exifr)
library(raster)
####------------------------------------
EXIF_GPS=exif_2_df(GPS_dir_1)
####------------------------------------
GPS_list=list.files(path=GPS_dir,pattern=format,ignore.case=T,full.names=T)
NO_GPS_list=list.files(path=NO_GPS_dir,pattern=format,ignore.case=T,full.names=T)
####------------------------------------
if(length(NO_GPS_list)!=length(GPS_list)){stop("distinto numero de imagenes")}
####------------------------------------
for(i in 1:length(NO_GPS_list)){
  ####------------------------------------
  print_v=c("Procesando img ",i,"de",length(NO_GPS_list))
  print(print_v)
  ####------------------------------------
  image=NO_GPS_list[[i]]
  ####------------------------------------
  ################ SECUENCIA PARA MODIFICAR LOS DATOS EXIF de las imagenes sin geotag
  gps_vector_1_stamp=c("GPSLatitudeRef","GPSLongitudeRef","GPSAltitudeRef","GPSTimeStamp","GPSMeasureMode","GPSDilutionOfPrecision","GPSSpeedRef","GPSSpeed","GPSTrackRef","GPSTrack","GPSDateStamp","GPSAltitude","GPSDate/Time","GPSLatitude","GPSPosition")
  gps_vector_2_stamp=c("gpslatituderef","gpslongituderef","gpsaltituderef","gpstimestamp","gpsmeasuremode","gpsdop","gpsspeedref","gpsspeed","gpstrackref","gpstrack","gpsdatestamp","gpsaltitude","gpsdatetime","gpslatitude","gpsposition")
  #### armo tres commands para el EXIF tools
  command_train_1=paste("exiftool -",gps_vector_2_stamp[1],"=",EXIF_GPS$GPSLatitudeRef[i]," -",gps_vector_2_stamp[2],"=",EXIF_GPS$GPSLongitudeRef[i]," -",gps_vector_2_stamp[3],"=",EXIF_GPS$GPSAltitudeRef[i]," -",gps_vector_2_stamp[4],"=",EXIF_GPS$GPSTimeStamp[i]," -",gps_vector_2_stamp[5],"=",EXIF_GPS$GPSMeasureMode[i],sep="")
  command_train_2=paste(command_train_1," ",image,sep="")
  system(command_train_2)
  ####------------------------------------
  command_train_3=paste("exiftool -",gps_vector_2_stamp[6],"=",EXIF_GPS$GPSDOP[i]," -",gps_vector_2_stamp[7],"=",EXIF_GPS$GPSSpeedRef[i]," -",gps_vector_2_stamp[8],"=",EXIF_GPS$GPSSpeed[i]," -",gps_vector_2_stamp[9],"=",EXIF_GPS$GPSTrackRef[i]," -",gps_vector_2_stamp[10],"=",EXIF_GPS$GPSTrack[i],sep="")
  command_train_4=paste(command_train_3," ",image,sep="")
  system(command_train_4)
  ####------------------------------------
  command_train_5=paste("exiftool -"," -",gps_vector_2_stamp[15],"=",EXIF_GPS$GPSPosition[i],sep="")
  command_train_6=paste(command_train_3," ",image,sep="")
  system(command_train_6)
  ####------------------------------------
  command_7=paste("exiftool -gpsaltitude=",EXIF_GPS$GPSAltitude[i]," -gpslatitude=",EXIF_GPS$GPSLatitude[i]," -gpslongitude=",EXIF_GPS$GPSLongitude[i]," -gpsdatestamp=",EXIF_GPS$GPSDateStamp[i]," -gpsdatetime=",EXIF_GPS$GPSDateTime[i]," ",image,sep="")
  system(command_7)
  ################ FIN SECUENCIA PARA MODIFICAR LOS DATOS EXIF de las imagenes sin geotag
  ####------------------------------------
  to=paste("GPS_",basename(image),sep="")
  to=file.path("EXIF_STAMPED",to)
  directoryExists("EXIF_STAMPED")
  file.rename(image,to)
  ####------------------------------------
  }#### cierro el for loop
}#### cierro la funcion

##########################################
########### FUNCIONES ####################
##########################################


##########################################
##########################################
## esta funcion extrae los              ##
## los datos EXIF de una lista          ##
## de imagenes en una carpeta y         ##
## devuelve un dataframe con los datos  ##
##########################################
##########################################
## input: path donde estan las imagenes ##
## y el formato de imagenes a buscar    ##
## output: dataframe con EXIF data      ##
##########################################
exif_2_df=function(path,format=".jpg"){
  ##------##
  library(exifr)
  library(raster)
  ##------##
  img_list=list.files(path=path,pattern=format,ignore.case=T,full.names=T,recursive=T)
  ##------##
  exif_data=read_exif(path=img_list, tags = NULL, recursive = FALSE, args = NULL,quiet = TRUE)
  ##------##
  return(exif_data)
  ##------##
}
##########################################
#### FIN DE LA FUNCION             #######
##########################################
  
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
##########################################
#### FIN DE LA FUNCION             #######
##########################################
  
