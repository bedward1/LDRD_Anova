# code to process for anova
# bryan linggi
# started 9/9/13
# input: 1, file location
# output: 1. anova model 

really.big.ws=readWorksheetFromFile('bothsets.xlsx',sheet=1,header=T)
#subset out rows not used
really.big.ws=really.big.ws[,3:14]

#set factor levels , should be same for any set same design experiments

really.big.ws$primerset=factor(really.big.ws$primerset,levels=c('IL8','p21'),labels=c('IL8','p21'))
really.big.ws$EGF=factor(really.big.ws$EGF,levels=c(0,0.1,100),labels=c('low','med','high'))
really.big.ws$TGFB=factor(really.big.ws$TGFB,levels=c(0,0.1,10),labels=c('low','med','high'))
really.big.ws$Serum=factor(really.big.ws$Serum,levels=c(0,10),labels=c('low','high'))
really.big.ws$ijnk=factor(really.big.ws$ijnk,levels=c(0,1),labels=c('none','high'))
really.big.ws$imek=factor(really.big.ws$imek,levels=c(0,1),labels=c('none','high'))
really.big.ws$immp=factor(really.big.ws$immp,levels=c(0,1),labels=c('none','high'))
really.big.ws$ip3ik=factor(really.big.ws$ip3ik,levels=c(0,1),labels=c('none','high'))
really.big.ws$ismad=factor(really.big.ws$ismad,levels=c(0,1),labels=c('none','high'))
really.big.ws$istat=factor(really.big.ws$istat,levels=c(0,1),labels=c('none','high'))
really.big.ws$isrc=factor(really.big.ws$isrc,levels=c(0,1),labels=c('none','high'))

aov.out2=aov(Fold.Change~ .*. ,really.big.ws)
summary(aov.out2)
TukeyHSD.aov(aov.out2)
plot(aov.out2)