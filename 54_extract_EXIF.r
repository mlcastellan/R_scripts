################################################
#### Esta funcion recibe el path de una      ###
#### img tiff o jpg y mediante  exiftools    ###
#### extrae los datos exiff de la imagen     ###
#### y los guarda en formato txt en una      ###
#### carpeta llamada EXIF                    ###
################################################

extract_exif=function(image_filename){
  #-------------------------------------------
  library(raster)
  library(rgdal)
  library(stringr)
  #-------------------------------------------
  if(dir.exists("EXIF")==FALSE){dir.create("EXIF")}
  #-------------------------------------------
  if(str_detect(toupper(image_filename),pattern=".JPG")){
    filename_txt=basename(str_replace(image_filename,pattern=".JPG",replacement=".txt"))
  }
  if(str_detect(toupper(image_filename),pattern=".TIF")){
    filename_txt=basename(str_replace(image_filename,pattern=".TIF",replacement=".txt"))
  }
  #-------------------------------------------
  read_exif_command=paste("exiftool",image_filename)
  exif_data=system(read_exif_command,intern=TRUE)
  #-------------------------------------------
  filename_txt=file.path("EXIF",basename(filename_txt))
  
  fileConn<-file(filename_txt)
  writeLines(exif_data, fileConn)
  close(fileConn)
  
  
}