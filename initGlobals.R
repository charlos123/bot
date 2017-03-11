source("telConnector.R")
assign("bot", telConnector.initBot(), envir = .GlobalEnv)


todaysTriggers <- NULL
assign("todaysTriggers", todaysTriggers, envir = .GlobalEnv)


## TODO: remove
qq <- 33
assign("qq", qq, envir = .GlobalEnv)
