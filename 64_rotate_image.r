##############################################
### este script rota una imagen            ###
### jpg un cierto angulo (90,180,270)      ###
### en grados.                             ###
##############################################
##############################################
## input: directorio con imagenes a rotar   ##
##output: imagenes rotadas un cierto angulo ##
##############################################
img_dir="C:/Users/mm/Documents/Solfrut_NIR"
angle=180
##############################################
##############################################
rotate_image_degrees(img_dir=img_dir,angle=angle)
##############################################
##############################################
###
rotate_image_degrees=function(img_dir,angle){
##
library(magick)
library(parallel)
##
  # Calculate the number of cores
  #no_cores <- detectCores() - 1
  # Initiate cluster
  #cl <- makeCluster(no_cores)
#######################################
#img_loc=image_read=file.choose()
#image_info(img)
#plot(img)
img_list=list.files(path=img_dir,full.names=T)
## i=1
for(i in 1:length(img_list)){
##
img_loc=img_list[[i]]
##
img=image_read(path=img_loc, density = NULL, depth = NULL, strip = FALSE)
##
img_rotated=image_rotate(img,angle)
#plot(img_rotated)
##
image_write(img_rotated,path=img_loc, format ="JPEG")
print(i)
gc()
rm(img)
rm(img_rotated)
rm(img_loc)
gc()
}
##############################################
#stopCluster(cl)  
##############################################
}
##############################################
#####   FIN DE LA FUNCION    #################
##############################################
