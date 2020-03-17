rm(list=ls())
getwd()
setwd("/home/martin-r")
#-------------------------------------------
library(raster)
library(rgdal)
#-------------------------------------------
file_path="/home/martin-r/20180805_mendoza_soleado/S2A_MSIL1C_20170804T144131_N0205_R053_T19HED_20170804T144145.SAFE"
#-------ejecuto sen2cor desde dentro de r
sen2cor_cmd <- paste("/home/martin-r/SEN2COR/Sen2Cor-02.05.05-Linux64/bin/L2A_Process ",file_path)
#sen2cor_cmd <- paste("/home/seanroulet/SEN2COR/Sen2Cor-02.05.05-Linux64/bin/L2A_Process --resolution 10",file_path)
system(sen2cor_cmd)


## Ignorar lo que sigue.  Es solo para ver que esta pasando con los permisos.
# system("whoami")
# system("pwd")
# system("/home/seanroulet/SEN2COR/Sen2Cor-02.05.05-Linux64/bin/L2A_Process --help")
# "S2A_MSIL1C_20180714T103021_N0206_R108_T32TNT_20180714T124331.SAFE"