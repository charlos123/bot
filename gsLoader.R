source("credentials.R")
require(googlesheets)

gsLoader.loadSceduleData <- function(
    ss = getOption("bot.gs_url"), 
    ws = getOption("bot.gs_df_ws")){

  ss <- gs_url(ss)
  schedule.df <- gs_read(ss, ws)
  
  # converting df to list
  schedule.list <- split(schedule.df, seq(nrow(schedule.df)))
  schedule.list <- setNames(split(schedule.df, seq(nrow(schedule.df))), rownames(schedule.df))
  
  return(schedule.list)
}