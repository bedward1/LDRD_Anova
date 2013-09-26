# preprocessing step 
# linggi Sept 23,2013
# input, raw .xls file 'ws'
# output, diagnostics file 
#i. check for non-response
require(XLConnect)
setwd('/Volumes/Documents-1/R_onAir/Anova_LDRD/LDRD_anova_projtemp/data/')
ws=readWorksheetFromFile('20130917_MDAMB231_HMEC_Anova_Data.xlsx',sheet=1,header=T)

response.var=ws$Fold.Change
summary(response.var)
   
# determine data coding 
rm(bworkbook)
bworkbook=loadWorkbook('../diagnostics/levels.xls',create=TRUE)
createSheet(bworkbook,name='levplotels')
description=paste((date()),'diagnostics: LEVELS of column data')
writeWorksheet(description,object=bworkbook, sheet='levels', startRow=1,header=F)
writeWorksheet(t(colnames(ws)),object=bworkbook, sheet='levels', startRow=3, startCol=2)
ws.factored=ws
for (i in  1:ncol(ws)){
  #output all levels for factors
  writeWorksheet(levels(as.factor(ws[,i])), object= bworkbook,sheet='levels',startCol=i+1,startRow=5,header=F)
  #convert every column to factor and save it to new matrix 
  if (i!=21){
  ws.factored[,i]= as.factor(ws[,i])
}
}
# output to file (put link in journal)
saveWorkbook(bworkbook)



# make new sheet and export summary
createSheet(bworkbook,name='levels_summary')
writeWorksheet(summary(ws.factored),object=bworkbook,sheet='levels_summary')
saveWorkbook(bworkbook)

##initial data analysis

#print boxplot of data
jpeg(file='../diagnostics/boxplot_factored_data.jpeg')
boxplot(ws.factored,las=2)
dev.off()

#noticed an outlier. also in summary data
which(ws.factored$Fold.Change==(max(ws.factored$Fold.Change,na.rm=TRUE)))
#remove this row, is a bad entry or datapoint for some reason
ws.factored.v2=ws.factored[-which(ws.factored$Fold.Change==(max(ws.factored$Fold.Change,na.rm=TRUE))) ,]
# now plot again
jpeg(file='../diagnostics/boxplot_factored_data.v2.jpeg')
boxplot(ws.factored.v2,las=2)
dev.off()

#print out summary
write.csv(data.frame(summary(ws.factored.v2)),'../diagnostics/summary_ws_factored_v2.csv')

# look at basic plots 
pairs(~Fold.Change+TGFB+EGF+Serum,data=ws,log='xy')

jpeg()
dev.off()

require(ggplot2)
attach(ws)
plot1 = ggplot(data=ws,aes(x=Fold.Change,y=TGFB))+geom_jitter(aes(color=Cell.Line, size=EGF, ))+ scale_x_log10()scale_y_log10()
plot1

plot2 = ggplot(data=ws.factored.v2, aes(x=Fold.Change,y=primerset))+ geom_jitter()+scale_x_log10() +geom_jitter(aes(color=EGF, shape=Cell.Line))
plot2

plot3 = ggplot(data=subset(ws.factored.v2,ws.factored.v2$Cell.Line=='HMEC' & ws.factored.v2$Density=='High'), aes(x=Fold.Change,y=primerset))+ geom_jitter()+scale_x_log10() +geom_jitter(aes(color=EGF, shape=TGFB))
plot3
pairs()
