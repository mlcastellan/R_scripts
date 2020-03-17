##########################################################################
########### funcion de calculo de Wilting Point y Saturacion de suelo ####
##########################################################################

##### la funcion se tomo de la siguiente pagina     ######################
#http://resources.hwb.wales.gov.uk/VTC/env-sci/module2/soils/soilwatr.htm#
##########################################################################


soil_saturation_properties=function(percent_sand=20.0,percent_clay=20.0){
  
PWP=0.0#Perm.Wilt.Point(cm3/cm3)%expressedasadecimal
FC=0.0#FieldCapacity(cm3/cm3)%expressedasadecimal
SAT=0.0#Saturation(cm3/cm3)%expressedasadecimal
KSAT=0.0#Saturatedhydraulicconductivitycm/hr
PAW_inch_foot=0.0#PlantAvailableWaterin/foot%
PAW=0.0#PlantAvailableWater(cm3/cm3)%expressedasadecimal

acoef=0.0
bcoef=0.0
sand_2=0.0#sandsquared
clay_2=0.0#claysquared

percent_total=(percent_sand+percent_clay)

if(percent_total>100){
  percent_sand=0
  percent_clay=0
}

if((percent_sand>0)&&(percent_clay>0)){
  
sand_2=percent_sand*percent_sand

clay_2=percent_clay*percent_clay

acoef=exp(-4.396-(0.0715*percent_clay)-(4.88e-4*sand_2)-(4.285e-5*sand_2*percent_clay))

bcoef=-3.140-(0.00222*clay_2)-(3.484e-5*sand_2*percent_clay)

SAT=0.332-7.251e-4*percent_sand+0.1276*log10(percent_clay)
}

if((acoef!=0.0)&&(bcoef!=0.0)){
  FC=((0.3333/acoef)^(1.0/bcoef))
  PWP=((15.0/acoef)^(1.0/bcoef))
}

if(SAT!=0.0){
  KSAT=exp(12.012-(0.0755*percent_sand)+(-3.895+0.03671*percent_sand-0.1103*percent_clay+8.7546e-4*clay_2)/SAT)
}

PAW=(FC-PWP)
PAW_inch_foot=PAW*12.0#converttoin/foot


#### el output son las variables PWB y SAT
output_vector=c(PWP,SAT)
return(output_vector)
##########################################

}


######################################################
#########     FUNCION ORIGINAL             ###########
######################################################

#function compute_display_properties(percent_sand,percent_clay,result_form)
#{
#  var PWP   =0.0;  // Perm. Wilt. Point (cm3/cm3) % expressed as a decimal
#  var FC    =0.0;  // Field Capacity    (cm3/cm3) % expressed as a decimal
#  var SAT   =0.0;  // Saturation  (cm3/cm3) % expressed as a decimal
#  var KSAT  =0.0;  // Saturated hydraulic conductivity  cm/hr
#  var PAW_inch_foot   =0.0;  // Plant Available Water   in/foot %
#  var PAW   =0.0;  // Plant Available Water   (cm3/cm3) % expressed as a decimal

#  var acoef =0.0;
#  var bcoef =0.0;
#  var sand_2=0.0;  // sand squared
#  var clay_2=0.0;  // clay squared

#  //var percent_sand = parseFloat(percent_sand_str);
#  //var percent_clay = parseFloat(percent_clay_str);

#  var percent_total = (percent_sand + percent_clay);

#  if (percent_total > 100) 
#  {  percent_sand = 0
#     percent_clay = 0
#  };

 # if ((percent_sand > 0) && (percent_clay > 0))
#  {
#    sand_2 = percent_sand * percent_sand;
#    clay_2 = percent_clay * percent_clay;

#    acoef = Math.exp(-4.396 - 0.0715 * percent_clay -4.88e-4 * sand_2 - 4.285e-5 * sand_2 * percent_clay);
#    bcoef = - 3.140 - 0.00222 * clay_2 - 3.484e-5 * sand_2 * percent_clay;
#    SAT = 0.332 - 7.251e-4 * percent_sand + 0.1276 * log10(percent_clay);
#    if ((acoef != 0.0) && (bcoef != 0.0))
#    {
#      FC   = Math.pow((0.3333/ acoef),(1.0 / bcoef));
#      PWP  = Math.pow((15.0  / acoef),(1.0 / bcoef));
#    }

#    if (SAT != 0.0)
#      KSAT =Math.exp((12.012 - 0.0755 * percent_sand)  + (- 3.895 + 0.03671 * percent_sand -0.1103  * percent_clay + 8.7546e-4 * clay_2)/ SAT);
#  };
#  PAW = (FC - PWP);    
#  PAW_inch_foot = PAW * 12.0   // convert to in/foot;

#  var prcnt_sand = percent_sand;
#  var prcnt_clay = percent_clay;


#   result_form.percent_sand.value      = prcnt_sand;
#   result_form.percent_clay.value      = prcnt_clay;
#   result_form.wilting_point.value     = PWP;  
#   result_form.field_capacity.value    = FC;
#   result_form.saturation.value        = SAT;
#   result_form.sat_hydraulic_cond.value= KSAT;
#   result_form.available_water.value   = PAW;
#   result_form.available_water_inch_foot.value = PAW_inch_foot;
#};
######################################################
######################################################
######################################################
