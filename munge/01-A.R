# Preprocessing script.  
 
degree.tbl[, `:=`(ID, .I)]
# FY16.rpt[, `:=`(ID, .I)]
FY17 <- FY17TuitionDiff.X2016TuitionDiffIndebtedness
FY17$FY.2017 <- as.character(FY17$FY.2017)

FY18 <- FY18TuitionDiff.Export.Worksheet
FY19 <- FY19TuitionDiff.Export.Worksheet

names(FY17Tuition.Source)[2] <- "TYPE"                                                              # rename columns to sync joins
names(FY18Tuition.Source)[2] <- "TYPE"                                                              # rename columns to sync joins
names(FY18Tuition.Source)[4] <- "FY.2018"                                                           # rename columns to sync joins

# fy17_long <- gather(FY17, category, FY.2017, -DEGREE.MAJOR) %>% arrange(DEGREE.MAJOR)
fy18_long <-gather(FY18, category, FY.2018, -TYPE) %>% arrange(TYPE) %>%
            left_join(., jctTbl.indebtedness, by = 'category') %>%                                  # Use index to reference a column                                               https://tinyurl.com/y7nra5h2
            mutate(b = ifelse(is.na(DEGREE.MAJOR),.[[2]] , DEGREE.MAJOR))                           # take the value in column 2 in there is a  na in column 3, i.e. DEGREE.MAJOR   https://tinyurl.com/yck2bdje
fy19_long <-gather(FY19, category, FY.2019, -TYPE) %>% arrange(TYPE) %>%
            left_join(., jctTbl.indebtedness, by = 'category')                                      # Use index to reference a column                                               https://tinyurl.com/y7nra5h2

rm(list = ls()[grepl("(SQL|Sheet|Export|X2016Tuition)", ls())])                                     # Remove worksheets programmatically.  Delete objects with 'SQL' 'Sheet' 'Export' 'X2016Tuition' in name

FY17Tuition.Source <- left_join(FY17Tuition.Source, jctTbl.source, by = "DETAIL_CODE_DESC")%>% 
            select(5,4,2) %>%
            select_all(~gsub("COUNT", "FY.2017", .)) %>%                                            # modify Column Name if equal to count then change to 'FY.2017'
            mutate_at(c(2), as.character)                                                           # Change select columns from character to integers                              https://tinyurl.com/ycyxzarn

fy17_long <- select(FY17, 1, 5) %>%
            left_join(., jctTbl.degree, by = "DEGREE.MAJOR") %>%
            mutate_at(.vars = vars(1:2), .funs = funs(ifelse(is.na(.), "", .))) %>%                 # remove na's so they don't propagate to the other columns in the next statement, i.e, na.locf(., 3) %>%
            na.locf(., 3) %>%
            bind_rows(., FY17Tuition.Source)

FY18Tuition.Source <- left_join(FY18Tuition.Source, jctTbl.source, by = "DETAIL_CODE_DESC")

fy18_long <-FY18Tuition.Source  %>% 
            select(2,5,4) %>%
            bind_rows(., fy18_long) %>%
            select(2,1,3)

FY19Tuition.Source <- left_join(FY19Tuition.Source, jctTbl.source, by = "DETAIL_CODE_DESC")

fy19_long <-FY19Tuition.Source  %>% 
            select(2,5,4) %>%
            bind_rows(., fy19_long) %>%
            select(2,1,3)

tuition.rpt <- inner_join(FY16.rpt, jctTbl.degree, by = "TYPE") %>%
            mutate_at(.vars = vars(1:8), .funs = funs(ifelse(is.na(.), "", .))) %>%                 # remove na's so they don't propagate the other columns
            na.locf(., 9) %>%                                                                       # fill values from rows above -                                                 https://tinyurl.com/y7cfg64v
            select_all(~gsub(".x", "", .)) %>%                                                      # modify Column Name if equal to DEGREE.MAJOR.x then change to DEGREE.MAJOR
            left_join(., fy17_long, by = c("DEGREE.MAJOR", "TYPE")) %>%  
            left_join(., fy18_long, by = c("DEGREE.MAJOR", "TYPE")) %>%
            left_join(., fy19_long, by = c("DEGREE.MAJOR", "TYPE")) %>%
            replace(., is.na(.), "") %>%
            select(., -1, -(3:4), -(7:10))  %>%                                                     # exclude columns 1,3,4,7 & 10                                                  https://tinyurl.com/y8m5llmo
#           mutate(b = ifelse(is.na(DEGREE.MAJOR),.[[2]] , DEGREE.MAJOR)) %>%                       # take the value in column 2 in there is a  na in column 3, i.e. DEGREE.MAJOR   https://tinyurl.com/yck2bdje
            mutate_at(.vars = vars(2:5), .funs = funs(ifelse(grepl("^FY 20", .), " ", .)))  %>%     # replace values in rows that match "^FY 20" with blanks " "                    https://tinyurl.com/y9xhh7nz
            mutate(FY.2020.est = round(as.integer(.[[6]])*1.05),0) %>%
            mutate_all(.funs = funs(ifelse(is.na(.), " ", .)))                                      # replace NA in a dplyr chain                                                   https://tinyurl.com/yck2bdje

write.xlsx(tuition.rpt, "reports/tuition.xlsx", row.names = F, sheetName = "rpt", 
    append = FALSE)