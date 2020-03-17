##########################################
##########################################
### Este script recorta una imagen al   ##
### bbox de tensorflow y  posterior     ##
### identifica el texto dentro del bbox ##
##########################################
##########################################
### input: input image to ientify       ##
### output: image text                  ##
##########################################
img=file.choose()
#-----------------------------------------
txt_OCR=function(img_path){
  #-------------------------
  library(tesseract)
  library(magick)
  #-------------------------
  img=image_read(img_path)
  img_gray=image_quantize(img,colorspace = 'gray')
  ##----
  text <- tesseract::ocr(img_gray)
  ##----
  return(text)
}
#-----------------------------------------
##################################################
### END OF FUNCTION                            ###
##################################################
