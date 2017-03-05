source("gsLoader.R")

#
# Tests
#

gsLoader.loadSceduleData.test <- function(){
  #test default file and DF data
  res <- gsLoader.loadSceduleData()
  
  if (res[[1]]$takingNum != 1) writeLines("gsLoader.loadSceduleData.test Failed") else writeLines("gsLoader.loadSceduleData.test Pass")
  if (res[[2]]$takingNum != 2) 
    writeLines("gsLoader.loadSceduleData.test Failed") else writeLines("gsLoader.loadSceduleData.test Pass")
}

gsLoader.loadSceduleData.test()
