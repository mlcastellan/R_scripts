##########################################
##########################################
### Este lee un pdf y lo exporta en     ##
### formato txt                         ##
##########################################
##########################################
### input: PDF a leer y lenguaje        ##
### output: texto dentro del pdf        ##  
##########################################
lan="esp"
pdf_path=file.choose()
##########################################

tesseract_pdf_2_text=function(pdf_path,lang="eng"){
#----
library(tesseract)
library(beepr)
#----
tesseract_download(lang)
beep()
#TESSDATA_PREFIX="c:\Users\mm\AppData\Local\tesseract4\tesseract4\"
##----
lan <- tesseract(lang)
text <- tesseract::ocr(pdf_path, engine = lan)
beep()
##----
return(text)
#----
}
#----
##########################################
### FIN DE LA FUNCION            #########
##########################################

