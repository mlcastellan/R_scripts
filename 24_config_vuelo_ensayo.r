#16-01-19 SCRIPT para calcular,pixel,tamaño de imagen y tiempo estre disparos
#Parametros a crear/ingresar son datos CSD,dato_ensayo,rango de altura de vuelo,rango de velocidades,traslapo x,traslapo y
#Parametros de salida: tamaño de pixel ,tiempo entre disparos
#CSD_largo-----> largo en pixels del csd
#CSD_ancho-----> ancho en pixels del csd
#dato_ensayo------------> ensayo de cm/pixel realizado a una distancia mayor a 50m
#TRASLAPO_X----->% DE TRASLAPO EN DIRECCION DE VUELO(70,60,80,ETC)
#TRASLAPO_Y----->% DE TRASLAPO PERPENDICULAR AL VUELO(80,70,ETC)
#GS----->Velocidad de vuelo sobre terreno en KTS
#--------------------------------------------------------#
in_dato_ensayo=0.0036#[cm/pixel]
in_CSD_largo=6000#[pixeles]
in_CSD_ancho=4000#[pixeles]
in_traslapo_x=80#[%]
in_traslapo_y=80#[%]
in_GS=50#[kts]
in_h_vuelo_ft=10000#[ft]
#--------------------------------------------------------#
config_vuelo_ensayo=function(dato_ensayo=in_dato_ensayo,CSD_ancho=in_CSD_ancho,CSD_largo=in_CSD_largo,traslapo_x=in_traslapo_x,traslapo_y=in_traslapo_y,GS=in_GS,h_vuelo_ft=in_h_vuelo_ft){
#--------------------------------------------------------#
dato_ensayo_m=dato_ensayo/100#[m]
h_vuelo_m=h_vuelo_ft*0.3048#[m]
traslapo_x=traslapo_x/100
traslapo_y=traslapo_y/100
###----
lado_pixel=dato_ensayo_m*h_vuelo_m#[m]
###----
img_fren=CSD_largo*lado_pixel#[m]
img_prof=CSD_ancho*lado_pixel#[m]
###----
GS_m_s=GS*0.51444#[m/s]
d_fotos_x=(1-traslapo_x)*img_prof
d_pasada=(1-traslapo_y)*img_fren
t_fotos=d_fotos_x/GS_m_s
#--------------------------------------------------------#
return(c(lado_pixel,img_fren,img_prof,d_fotos_x,d_pasada,t_fotos))
#--------------------------------------------------------#

}
#--------------------------------------------------------#
datos_camara=data.frame()
datos_camara=cbind.data.frame(seq(50,120,10))
names(datos_camara)="GS_[kts]"
#--------------------------------------------------------#
datos_fun=data.frame()
for(i in 1:nrow(datos_camara)){
  datos_fun[i,1]=cbind.data.frame(config_vuelo_ensayo(GS=datos_camara[i,1]))
  names(datos_fun)=c("lado_pixel[m]","frente [m]","fondo [m]","dist fotos x [m]","dist pasadas [m]","tiempo [s]")
  
}

}