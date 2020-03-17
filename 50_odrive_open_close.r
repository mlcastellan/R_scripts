

photo_list=list.files(path="C:/Users/MC1988/odrive/Facebook",pattern=".jpg.cloud$",all.file=TRUE,full.names=TRUE,recursive=TRUE,ignore.case=TRUE)


for(i in 1:length(photo_list)){
  
 ff=photo_list[i] 

#system2("open", ff)

shell.exec(ff)
Sys.sleep(0.8)
system("taskkill /f /im dllhost.exe")
Sys.sleep(0.8)
print(i)

}

