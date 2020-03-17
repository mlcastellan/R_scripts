########################################
########################################
## esta funcion renombra y crea      ###
## las carrpetas y archivos          ###
## necesarios para el procesamiento  ###
## de los viñedos                    ###
########################################
########################################
path="C:/Users/mm/Documents/006_PROCESAMIENTO_2019/002_ESTRUCTURA_CARPETAS/2019_XXX_XXX/"
year="2019"
fincas=c("NORTON_LA_COLONIA","NORTON_PERDRIEL","NORTON_AGRELO","SALENTEIN_EL_OASIS","SALENTEIN_LA_PAMPA","SEPTIMA_SEPTIMA","SOLFRUT","SOPHENIA","TRIADA","TRIVENTO_LOS_INDIOS","TRIVENTO_CRUZ_DELALTO","TRIVENTO_LOS_SAUCES","VICIANA")

for(i in 1:length(fincas)){
  finca=fincas[[i]]
  create_folders_4_process(orig_path=path,year="2019",finca=finca)
  
}
#######################################
create_folders_4_process(orig_path=path,year="2019",finca=finca)
#######################################

create_folders_4_process=function(orig_path,year="2019",finca){
########################################
library(stringr)
library(dplyr)
########################################
####
dir_names=list.dirs(path=orig_path, full.names = TRUE, recursive = TRUE)
new_dirs=str_replace_all(dir_names,"2018",year)
new_dirs=str_replace_all(new_dirs,"XXX_XXX",finca)
####
for(i in 1:length(new_dirs)){
  directoryExists(new_dirs[i])
}
###
#### Pego la planilla de la tabla de atributos y pdf
estad=list.files(path=path,pattern=".xls",full.names = TRUE, recursive = TRUE,ignore.case=T)
pdf=list.files(path=path,pattern=".pdf",full.names = TRUE, recursive = TRUE,ignore.case=T)
####
estad_path=paste(dir_names[1],"/",basename(estad),sep="")
estad_path=str_replace_all(estad_path,"XXX_XXX",finca)
file.copy(estad,estad_path,copy.mode=TRUE)
#### copio en la nueva ubicacion 
pdf_path=paste(new_dirs[1],"/",basename(pdf),sep="")
pdf_path=str_replace_all(pdf_path,"XXX_XXX",finca)
file.copy(pdf,pdf_path,copy.mode=TRUE)
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


