# Preprocessing script.
# Remove worksheets programmatically.  Delete objects with "SQL" and "Sheet" in name
degree.tbl[, ID := .I]
FY17 <- FY17TuitionDiff.X2016TuitionDiffIndebtedness
FY18 <- FY18TuitionDiff.Export.Worksheet
FY19 <- FY19TuitionDiff.Export.Worksheet
fy19_long <- gather(FY19,category,FY.2019,-TYPE) %>% arrange(TYPE)
rm(list = ls()[grepl("(SQL|Sheet|Export|X2016Tuition)", ls())])
df <- left_join(FY17,jctTbl.degree,by = "DEGREE.MAJOR")
df[is.na(df)] <- " "
# df1 <- left_join(FY17,degree.jctID,by = "DEGREE.MAJOR")%>%left_join(., FY19, by='TYPE')
df1 <- left_join(FY17,jctTbl.degree,by = "DEGREE.MAJOR")%>%left_join(., fy19_long, by='TYPE')
df1[is.na(df1)] <- " "
# df1[is.na(df1)] <- 0

degree.diff<-left_join(degree.tbl,jctTbl.amount, by='DEGREE.MAJOR')%>%left_join(.,fy19_long, by=c('TYPE', 'category'))%>% select(9, 1:7, 11)

# degree.diff<-inner_join(fy19_long,jctTbl.degree, by='TYPE')%>%inner_join(jctTbl.amount,., by=c('DEGREE.MAJOR', "category"))

write.xlsx(df, "reports/df0.xlsx", row.names=F, sheetName="df0", append=FALSE)
write.xlsx(df1, "reports/df0.xlsx", row.names=F, sheetName="df1", append=TRUE)

# Create College Reference dataframe
# FY17degree <- FY17TuitionDiff.X2016TuitionDiffIndebtedness %>% filter(is.na(FY.2017) & !is.na(DEGREE.MAJOR))  %>% select(1)
# FY17degree <- data.table(FY17degree)
# t_FY17degree <- setDT(transpose(FY17degree))
# t_FY19degree <- setDT(transpose(FY19TuitionDiff.Export.Worksheet[,1]))
# degree <- setDT(transpose(rbind.fill(t_FY17degree,t_FY19degree)))
# colnames(degree) <- c('DEGREE.MAJOR', 'TYPE') 