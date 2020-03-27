#############################################
## Script with use of fuzzy merge method   ##
##                                         ##
#############################################
#############################################
library(fuzzyjoin)

#----#
GDP_pcap_NOMINAL=read.csv(file.choose(),sep=";",stringsAsFactors=F)
GDP_pcap_PPP=read.csv(file.choose(),sep=";",stringsAsFactors=F)
GDP_hh_spending=read.csv(file.choose(),sep=";",stringsAsFactors=F)
life_expectance=read.csv(file.choose(),sep=";",stringsAsFactors=F)
infant_mortality=read.csv(file.choose(),sep=";",stringsAsFactors=F)
#----#
f <- Vectorize(function(x,y) agrepl(x, y,ignore.case=TRUE,max.distance = 0.01, useBytes = TRUE))
#----#
df_1=fuzzy_inner_join(GDP_pcap_NOMINAL,GDP_pcap_PPP, by="Country", match_fun=f)
colnames(df_1)[1] <- 'Country'
df_1=fuzzy_inner_join(df_1,GDP_hh_spending, by="Country", match_fun=f)
colnames(df_1)[1] <- 'Country'
df_1=fuzzy_inner_join(df_1,life_expectance, by="Country", match_fun=f)
colnames(df_1)[1] <- 'Country'
df_1=fuzzy_inner_join(df_1,infant_mortality, by="Country", match_fun=f)
colnames(df_1)[1] <- 'Country'
matches=df_1$Country==df_1$Country.y&df_1$Country==df_1$Country.y1&df_1$Country==df_1$Country.y2&df_1$Country==df_1$Country.y3
df_2=df_1[matches,]
df_2=df_2[c("Country","GPD.per.capita.Nominal","GDP.PPP.per.capita","Health...per.capita.USD_PPP","Overall","Female","Male","X2018.mortality.rate.under.5..per.1000.live.births.")]
rm(df_1)
#----#
write.csv2(df_2,file="world_data.csv")
