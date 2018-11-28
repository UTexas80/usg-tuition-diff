# Preprocessing script.

# Remove worksheets programmatically.  Delete objects with "SQL" and "Sheet" in name
FY17 <- FY17TuitionDiff.X2016TuitionDiffIndebtedness
FY18 <- FY18TuitionDiff.Export.Worksheet
FY19 <- FY19TuitionDiff.Export.Worksheet
rm(list = ls()[grepl("(SQL|Sheet|Export|X2016Tuition)", ls())])
df <- left_join(FY17,degree.jctID,by = "DEGREE.MAJOR")%>%left_join(., FY19, by='TYPE')
# Create College Reference dataframe
# FY17degree <- FY17TuitionDiff.X2016TuitionDiffIndebtedness %>% filter(is.na(FY.2017) & !is.na(DEGREE.MAJOR))  %>% select(1)
# FY17degree <- data.table(FY17degree)
# t_FY17degree <- setDT(transpose(FY17degree))
# t_FY19degree <- setDT(transpose(FY19TuitionDiff.Export.Worksheet[,1]))
# degree <- setDT(transpose(rbind.fill(t_FY17degree,t_FY19degree)))
# colnames(degree) <- c('DEGREE.MAJOR', 'TYPE') 