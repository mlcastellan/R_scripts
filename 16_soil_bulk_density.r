##########################################################################
########### funcion de calculo de Bulk density                        ####
##########################################################################

##### la funcion se tomo de la siguiente pagina     ######################
#https://www.researchgate.net/profile/Mohammad_Elnesr/publication/259198849_Saxton_Equations_to_determine_soil_physical_properties_in_MSExcel_format/data/0deec52a6c3e9002ca000000/Saxton-Equations-by-Dr-Mohammd-ElNesr.xlsx
##########################################################################


bulk_density=function(percent_sand=20.0,percent_clay=20.0){
 
percent_total=(percent_sand+percent_clay)

if(percent_total>100){
  percent_sand=0
  percent_clay=0
}
if((percent_sand>0)&&(percent_clay>0)){
#soil porosity
  POR=0.332-0.0007251*percent_sand+0.1276*log10(percent_clay)
# bulk density
  SBDM=(1-POR)*2.65
}
#### el output son las variables POR y SBDM
output=c(POR,SBDM)
return(output)
##########################################
}

######################################################
#########     FUNCION ORIGINAL             ###########
######################################################
##la funcion se extrajo de la planilla
##Saxton Equations by Dr. Mohammed El-Nsr