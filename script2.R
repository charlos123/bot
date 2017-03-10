library(telegram)
i<-NULL

source("/Users/olegkondratenko/Downloads/R projects/script1.R")

writeLines(paste(i))

bot <- TGBot$new(token = "366733950:AAH8i_bDRJYeTA_BRhxge7aoLFbf21eAuoY")

writeLines(paste(bot$getMe()))

