#coding:UTF-8
#download_sentinel.py
import sys
import os

uri=(sys.argv[1])
prod_01=(sys.argv[2])
link=uri+"("+"'"+prod_01+"'"+")"+"/"+"\\"+"$value"
#--------------------- 
#print(str(sys.argv))
#print len(sys.argv)
sys.stdout.write(link)
#--------------------------
#command=paste0("'","" wget -O ",dest," --no-check-certificate --continue --user=",usr," --password=",pass)



