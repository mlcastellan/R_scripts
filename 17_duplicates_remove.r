rm(list=ls())
#####
library(stringr)
#####
duplicados=list.files(path="C:/Users/MC1988/Documents/BIS_GOOGLE_DRIVE/PROFESIONALES-ACADEMICOS",pattern="\\(2\\)",full.names=TRUE,recursive=TRUE,ignore.case=TRUE)
duplicados=str_replace(duplicados,pattern="////",replacement="//")
#####
for (i in 1:length(duplicados)){
  new_name=str_replace(duplicados[i],pattern="\\(2\\)",replacement="_to_remove")
  file.rename(duplicados[i],new_name)
  print(i)
  }

#####
toremove=list.files(path="C:/Users/MC1988/Documents/BIS_GOOGLE_DRIVE/PROFESIONALES-ACADEMICOS",pattern="to_remove",full.names=TRUE,recursive=TRUE,ignore.case=TRUE)
#####

for (i in 1:length(toremove)){
  file.remove(toremove[i])
}
