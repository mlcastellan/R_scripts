################################################################
# this script converts a webpage into text, then translates it.#
################################################################
# input: url
# output: translated text version of url 
################################################################
#------------------------------------------------
url <- 'https://archive.org/web/'
target_lan="es"
#------------------------------------------------
text_extract_n_translate=function(url,target){
library(htm2txt)
library(googleLanguageR)
#---------------------------
text <- gettxt(url)[[1]]
source_lan=gl_translate_detect(substr(text,1,100))
source_lan=source_lan$language[1]

#------------------------------------------------
###
key="C:/Users/mm/Documents/004-meal-planner-05b26c53b224.json"
gl_auth(key)
###
target_text=gl_translate(text,source=source_lan,target=target)$translatedText
###
return(target_text)
#------------------------------------------------
}
################################################################
#### END OF SCRIPT                                          ####
################################################################