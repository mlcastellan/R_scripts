###########################################
#### Esta funcion edita el archivo EXIF ###
#### para leerlo facilmente como csv    ###
#### en un  dataframe                   ###
###########################################


edit_EXIF_file=function(tx){
  out_name=gsub(pattern = ".txt", replace = ".csv", x = tx,fixed=TRUE)
  tx  <- readLines(tx)
  tx2  <- gsub(pattern = ": ", replace = ";", x = tx,fixed=TRUE)
  writeLines(tx2, con=out_name)
  
}