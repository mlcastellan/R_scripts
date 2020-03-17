#23-04-18 SCRIPT para calcular, altitud de vuelo,frente y profundidad de pasada.
#Parametros a crear/ingresar son lado de pixel deseado,apertura angular y CSD_size
#lado_pixel---->xx deseado en cm
#ap------------> apertura angular de camara en grados
#CSD_largo-----> largo en pixels del csd
#CSD_ancho-----> ancho en pixels del csd
#TRASLAPO_X----->% DE TRASLAPO EN DIRECCION DE VUELO(70,60,80,ETC)
#TRASLAPO_Y----->% DE TRASLAPO PERPENDICULAR AL VUELO(80,70,ETC)
#GS----->Velocidad de vuelo sobre terreno en KTS
#--------------------------------------------------------#
getwd()
rm(list=ls())
#--------------------------------
lado_pixel=10
ap=24.4
CSD_largo=6000
CSD_ancho=4000
traslapo_x=80
traslapo_y=80
GS=80
#--------------------------------------------------------#
ap_rad=(ap*pi)/(180)
lado_pixel=lado_pixel/100#para pasar a metros
fren_img=CSD_largo*lado_pixel
prof_img=CSD_ancho*lado_pixel
area_img=fren_img*prof_img
h_vuelo_mt=prof_img/(2*tan(ap_rad/2))
h_vuelo_ft=h_vuelo_mt/0.3048
GS=GS*0.51444
d_shoot_x=(1-traslapo_x/100)*prof_img
d_pasada=(1-traslapo_y/100)*fren_img
t_fotos=GS/d_shoot_x
#--------------------------------------------------------#

