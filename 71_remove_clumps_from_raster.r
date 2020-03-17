###########################################
##### This function removes clumps of  ####
##### pixels of less than n elements   ####
###########################################
###########################################
## INPUT: raster, minimum clump size
## OUTPUT: filtered raster
###########################################
remove_clumps_from_raster=function(raster_loc,n=9){
#####
library(raster)
library(dplyr)
#####
raster_in=raster(raster_loc)
#####
raster_clumps <- clump(raster_in,gaps=F,directions=8)
## Assign freqency table to a matrix
clumpFreq <- freq(raster_clumps)
clumpFreq=as.data.frame(clumpFreq)
## which rows of the data.frame are only represented by n cells
str(which(clumpFreq$count<=n))
## which values do these correspond to?
str(clumpFreq$value[which(clumpFreq$count<=n)])

## Put these into a vector of clump ID's to be removed
excludeID <- clumpFreq[,1][which(clumpFreq[,2]<=n)]
## Make a new forest mask to be sieved
raster_sieve_mask=raster_clumps

## Assign NA to all clumps whose IDs are found in excludeID
raster_sieve_mask[raster_clumps %in% excludeID] <- NA
##
#???writeRaster(raster_sieve_mask,filename="raster_sieve_mask.tif",format="GTiff",overwrite=T)
##
return(raster_sieve_mask)
###########################################
}
###########################################
## End of script               ############
###########################################






