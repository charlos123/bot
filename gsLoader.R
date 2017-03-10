require(googlesheets)
source("gsCredentials.R")


gsLoader.loadScheduleData <- function(
    ss = getOption("bot.gs_url"), 
    ws = getOption("bot.gs_df_ws")){

  schedule.df <- gsLoader.loadScheduleData2Df(ss, ws)
  
  # converting df to list
  schedule.list <- split(schedule.df, seq(nrow(schedule.df)))
  schedule.list <- setNames(split(schedule.df, seq(nrow(schedule.df))), rownames(schedule.df))
  
  return(schedule.list)
}

gsLoader.loadScheduleData2Df <- function(
    ss = getOption("bot.gs_url"), 
    ws = getOption("bot.gs_df_ws")){

  ss <- gs_url(ss)
  schedule.df <- gs_read(ss, ws)
  
  return(schedule.df)
}