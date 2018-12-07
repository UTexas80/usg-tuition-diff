#dataMeta package processing
variable_type <- c(1, 1)
variable_description <- c("DETAIL_CODE_DESC", "DEGREE.MAJOR")
linker <- build_linker(my.data = jctTbl.source, variable_description = variable_description, variable_type = variable_type)
metadata <- build_dict(my.data = jctTbl.source, linker = linker, option_description = NULL, prompt_varopts = FALSE)