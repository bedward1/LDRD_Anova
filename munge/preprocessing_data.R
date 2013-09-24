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
createSheet(bworkbook,name='levels')
description=paste((date()),'diagnostics: LEVELS of column data')
writeWorksheet(description,object=bworkbook, sheet='levels', startRow=1,header=F)
writeWorksheet(t(colnames(ws)),object=bworkbook, sheet='levels', startRow=3, startCol=2)
ws.factored=ws
for (i in  1:ncol(ws)){
  writeWorksheet(levels(as.factor(ws[,i])), object= bworkbook,sheet='levels',startCol=i+1,startRow=5,header=F)
  ws.factored[,i]= as.factor(ws[,i])
}
# output to file (put link in journal)
saveWorkbook(bworkbook)



