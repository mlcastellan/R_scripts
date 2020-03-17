########################################
########################################
## esta funcion renombra los shp     ###
## a la version del año en curso    ###
## necesarios para el procesamiento  ###
## de los viñedos                   ###
########################################
########################################
path="C:/Users/mm/Documents/006_PROCESAMIENTO_2019/005_SHAPEFILES/001_ENPROCESO/Trivento Cruz del Alto"
year="2019"

#######################################
rename_shp_4_process(orig_path=path,year="2019")
#######################################

rename_shp_4_process=function(orig_path,year="2019"){
########################################
library(stringr)
library(dplyr)
########################################
####
shp_names=list.files(path=orig_path,full.names=T,recursive=T,include.dirs=T,ignore.case=T)
new_dirs=str_replace_all(shp_names,"2014",year)
new_dirs=str_replace_all(new_dirs,"2015",year)
new_dirs=str_replace_all(new_dirs,"2016",year)
new_dirs=str_replace_all(new_dirs,"2017",year)
new_dirs=str_replace_all(new_dirs,"2018",year)
####
for(i in(1:length(new_dirs))){

  file.rename(shp_names[i],new_dirs[i])
  
  
}

####
}
#### FIN DE LA FUNCION###########################



##############################
### FUNCIONES           ######
##############################

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


