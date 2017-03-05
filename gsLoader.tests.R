source("gsLoader.R")

#
# Tests
#

gsLoader.loadScheduleData.test <- function(){
  #test default file and DF data
  res <- gsLoader.loadScheduleData()
  
  if (res[[1]]$takingNum != 1) writeLines("gsLoader.loadScheduleData.test Failed") else writeLines("gsLoader.loadScheduleData.test Pass")
  if (res[[2]]$takingNum != 2) 
    writeLines("gsLoader.loadScheduleData.test Failed") else writeLines("gsLoader.loadScheduleData.test Pass")
}

gsLoader.loadScheduleData.test()