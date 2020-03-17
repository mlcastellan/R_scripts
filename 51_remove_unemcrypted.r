folder="C:/Users/mm/Google Drive/PERSONALES_A"

library(tools)
library(raster)
library(stringr)
library(chron)

setwd(folder)

lista_full=list.files(folder,full.names=T,ignore.case=T,recursive=T)
lista_boxcryptor=list.files(folder,pattern=".bc$",full.names=T,ignore.case=T,recursive=T)
lista_unencrypted=setdiff(lista_full,lista_boxcryptor)

for(i in 1:length(lista_unencrypted)){
 file.remove(lista_unencrypted[[i]])
}
