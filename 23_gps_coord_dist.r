#23-04-18 SCRIPT para calcular la distancia entre dos puntos dadas sus coordenadas GPS (LAT,LON)
#Parametros a crear/ingresar son POS1=(LAT1,LON1);POS2=(LAT2,LON2)
#Deben ingresarse los datos en notacion decimal, por ej 58.4555,34.5488
#Uso Haversine formula
#----------------------------------------------------------------------
POS1=c(05.00, 15.00)
POS2=c(05.00, 14.00)

DIST=function(POS1,POS2)
  {
  POS1_rad=POS1*(3.141516/180);
  POS2_rad=POS2*(3.141516/180);
  DLAT=POS2_rad[1]-POS1_rad[1];
  DLON=POS2_rad[2]-POS1_rad[2];
  rtierra_m=6371e3;
  a=sin(DLAT/2)*sin(DLAT/2) +
    sin(DLON/2)*sin(DLON/2)*cos(POS1_rad[1])*cos(POS2_rad[1]); 
  c=2*atan2(sqrt(a),sqrt(1-a)); 
  DISTANCIA=rtierra_m*c;
    #return(DISTANCIA); ver como pasarle el argumento a la funcion
   }



#----------------------------------------------------------------------

