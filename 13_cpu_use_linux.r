####################################################
# TEST IN LINUX BEFORE USE
#####################################################
## this script captures cpu,mem,pic usage in Linux #
## input: NA
## output: cpu,mem.pid.cmd
#####################################################
linux_cpu_use=function(){
#----#
splitted <- strsplit(system("ps -C rsession -o %cpu,%mem,pid,cmd", intern = TRUE), " ")
#-----#
df <- do.call(rbind, lapply(splitted[-1], 
                            function(x) data.frame(
                                cpu = as.numeric(x[2]),
                                mem = as.numeric(x[4]),
                                pid = as.numeric(x[5]),
                                cmd = paste(x[-c(1:5)], collapse = " "))))
#-----#
return(c(cpu,mem,pid,cmd))
#-----#
}
##################################### END #############
#######################################################





solo en linux uso system("ps -C rsession -o %cpu,%mem,pid,cmd", intern = TRUE)

