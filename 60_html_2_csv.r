#############################################
#############################################
## este script extrae los links de un     ###
## de un archivo html y los guarda        ###
## en formato csv                         ###
#############################################
#############################################
library(dplyr)
library(XML)
library(rvest)
library(stringr)
#############################################
## EXTRAIGO LINKS DE UN URL
url=file.choose()
##----#
links_df=scraplinks(url=url)
##EXPORTO LOS LINKS EN FORMATO CSV
out_name=str_replace(basename(url),pattern=".html",replacement=".csv")
write.csv(links_df,file=out_name,sep=";",row.names=F,col.names=F)
#############################################
## fin de la secuencia                   ####
#############################################










#############################################
#############################################
## FUNCIONES                            #####
#############################################
#############################################

#' Extract link texts and urls from a web page
#' @param url character an url
#' @return a data frame of link text and urls
#' @examples
#' \dontrun{
#' scraplinks("C:/Users/mm/Downloads/laborales_italia.html")
#' glinks <- scraplinks("http://google.com/")
#' }
#' @export
scraplinks <- function(url){
  # Create an html document from the url
  webpage <- xml2::read_html(url)
  # Extract the URLs
  url_ <- webpage %>% rvest::html_nodes("a") %>% rvest::html_attr("href")
  # Extract the link text
  link_ <- webpage %>%
    rvest::html_nodes("a") %>%
    rvest::html_text()
  return(data_frame(link = link_, url = url_))
}