##################################
# MAKE a simple raster with certain values
library(raster)
#----#
values=1
r<- raster(nrows = 3, ncols = 3,vals = values)
plot(r)
### END OF THE SCRIPT
##################################
