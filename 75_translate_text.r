########################################
### script to translate certain text  ##
###                                   ##
########################################
#### input:object to translate
#### output: translated text
########################################
text2tr <- "to administer medicince to animals is frequently a very difficult matter, and yet sometimes it's necessary to do so"
source="en"
target="es"
translate_text=function(source_lan=source,target_lan=target,text=text2tr){
  ###
  library(translateR)
  library(googleLanguageR)
  ###
  key="C:/Users/mm/Documents/004-meal-planner-05b26c53b224.json"
  gl_auth(key)
  ###
  target_text=gl_translate(text,source=source_lan,target="es")$translatedText
  return(target_text)
  ###
}
########################################
## FIN DE LA FUNCION                 ###
########################################

}