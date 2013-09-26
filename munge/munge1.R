# code to process for anova
# bryan linggi
# started 9/9/13
# input: 1, file location
# output: 1. diagnostic plots in 'diagnostic' folder in project template
require(XLConnect)
setwd('/Volumes/Documents-1/R_onAir/Anova_LDRD/LDRD_anova_projtemp/data/')
ws=readWorksheetFromFile('20130917_MDAMB231_HMEC_Anova_Data.xlsx',sheet=1,header=T)

#subset out rows not used
# subset out primer groups
ws$primerset=factor(ws$primerset,levels=c('IL8','p21'),labels=c('IL8','p21'))
primers=levels(ws$primerset)

for (i in primers)
{
  ws.primer=ws[ws$primerset==primers[1],4:14]

assign(paste("ws.", i,sep=""),ws[ws$primerset==i,4:14])
}

#set factor levels , should be same for any set same design experiments
ws=ws.primer
ws$primerset=factor(ws$primerset,levels=c('IL8','p21'),labels=c('IL8','p21'))

ws$EGF=factor(ws$EGF,levels=c(0,0.1,100),labels=c('low','med','high'))
ws$TGFB=factor(ws$TGFB,levels=c(0,0.1,10),labels=c('low','med','high'))
ws$Serum=factor(ws$Serum,levels=c(0,10),labels=c('low','high'))
ws$ijnk=factor(ws$ijnk,levels=c(0,1),labels=c('none','high'))
ws$imek=factor(ws$imek,levels=c(0,1),labels=c('none','high'))
ws$immp=factor(ws$immp,levels=c(0,1),labels=c('none','high'))
ws$ip3ik=factor(ws$ip3ik,levels=c(0,1),labels=c('none','high'))
ws$ismad=factor(ws$ismad,levels=c(0,1),labels=c('none','high'))
ws$istat=factor(ws$istat,levels=c(0,1),labels=c('none','high'))
ws$isrc=factor(ws$isrc,levels=c(0,1),labels=c('none','high'))

aov.out2=aov(Fold.Change ~ .*. ,ws)
summary(aov.out2)

write.csv(capture.output(summary(aov.out2)),'IL8_anova_results.csv')

#TukeyHSD.aov(aov.out2)
#plot(aov.out2)
