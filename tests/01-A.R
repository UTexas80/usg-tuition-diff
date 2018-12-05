tbl.Balance<-tbl.Balance%>% 
    group_by(osfaCode) %>%
    select(osfaCode, totBalFund, totBalStudent) %>%
    mutate(totBal = totBalFund - totBalStudent) %>%
    arrange(osfaCode)


df %>%  select(starts_with("FY.2")) %>%
        filter_all(., all_vars(grepl("FY"), .))
        mutate_if(starts_with("FY"), is.na)

 df[,2:6]        

# df <- left_join(FY17,jctTbl.degree,by = 'DEGREE.MAJOR') df[is.na(df)]
# <- ' '

# df1 <- left_join(FY17,jctTbl.degree,by =
# 'DEGREE.MAJOR')%>%left_join(., fy19_long, by='TYPE') df1[is.na(df1)]
# <- ' ' df1[is.na(df1)] <- 0


degree.diff <- left_join(degree.tbl, jctTbl.indebtedness, by = "DEGREE.MAJOR") %>% 
    left_join(., fy19_long, by = c("TYPE", "category")) %>%                     # dplyr join on multiple keys
    select(9, 1:7, 11)
degree.diff[is.na(degree.diff)] <- " "

# FY16.rpt <- FY16.rpt[FY17Tuition.Source[jctTbl.source, on = "DETAIL_CODE_DESC"], on=c("TYPE", "DEGREE.MAJOR.y")]                          # data.table join three (3) tables

write.xlsx(degree.diff, "reports/degreeDiff.xlsx", row.names = F, sheetName = "degreeDif", 
    append = FALSE)


# tuition_diff<- filter(FY16.Rpt, DEGREE.MAJOR == "PHARMD)" %>% 
# left_join(FY16.Rpt, degree.diff, by = "DEGREE.MAJOR" ) 
# write.xlsx(df1, 'reports/df0.xlsx', row.names=F, sheetName='df1',
# append=TRUE)

# Create College Reference dataframe FY17degree <-
# FY17TuitionDiff.X2016TuitionDiffIndebtedness %>%
# filter(is.na(FY.2017) & !is.na(DEGREE.MAJOR)) %>% select(1)
# FY17degree <- data.table(FY17degree) t_FY17degree <-
# setDT(transpose(FY17degree)) t_FY19degree <-
# setDT(transpose(FY19TuitionDiff.Export.Worksheet[,1])) degree <-
# setDT(transpose(rbind.fill(t_FY17degree,t_FY19degree)))
# colnames(degree) <- c('DEGREE.MAJOR', 'TYPE')

# tuition_diff <- left_join(FY16.Rpt, jctTbl.degree, by = "DEGREE.MAJOR" ) %>%
#            na.locf(., 8)

# degree.diff<-inner_join(fy19_long,jctTbl.degree,
# by='TYPE')%>%inner_join(jctTbl.indebtedness,., by=c('DEGREE.MAJOR',
# 'category'))


 df %>%  select(starts_with("FY")) %>%
    filter_all(all_vars(grepl('FY',.))) %>%
    mutate_at(., is.na)

    FY16.RptA <- left_join(FY16.RptA, jctTbl.degree, by = "DEGREE.MAJOR")
    FY16.RptA<-na.locf(FY16.RptA, 9)


FY17Tuition.Source[jctTbl.source, on = "DETAIL_CODE_DESC"]

FY18Tuition.SourceA <-  FY18Tuition.Source  %>% 
                          select(2,5,4) %>%
FY18A <- bind_rows(fy18_long, FY18Tuition.SourceA)


fy17_long <- select(FY17, 1, 4) %>%
            left_join(., jctTbl.degree, by = "DEGREE.MAJOR") %>%
            mutate_at(.vars = vars(1:2), .funs = funs(ifelse(is.na(.), "", .))) %>%                 # remove na's so they don't propagate the other columns
            na.locf(., 3) %>%                                                                       # fill values from rows above - https://tinyurl.com/y7c
tr<-tuition.rpt
tr <-       mutate_at(.vars, .funs = funs(ifelse(grepl('FY',.), "", .))) %>%                        # remove na's so they don't propagate the other columns
            na.locf(., 3) %>%                                                                       # fill values from rows above - https://tinyurl.com/y7c            

mtcars %>% mutate_at(vars(5:10), max)

t %>%   mutate_at(.vars = vars(3:8), .funs = funs(ifelse(grepl("FY 2"), "", .)))
t<-     mutate_at(.vars = vars(3:8), .funs = funs(ifelse(grepl('^FY',.), "", .)))


            
filter_all(all_vars(!grepl('FY 2',.)))                                                              #filter / Remove row if any column contains a specific string [grepl('FY 2')] in all columns              https://tinyurl.com/yc978h7v

mutate(b = ifelse(is.na(DEGREE.MAJOR),.[[2]] , DEGREE.MAJOR))                                       # take the value in column 2 in there is a  na in column 3, i.e. DEGREE.MAJOR   https://tinyurl.com/yck2bdje
mutate_at(.vars = vars(3:8), .funs = funs(ifelse(grepl("^FY 20", .), " ", .)))                      # replace values in rows that match "^FY 20" with blanks " "                    https://tinyurl.com/y9xhh7nz