source("scheduler.R")

#
# Sample Data
#
scheduler.getSampleSchedule <- function(){
  schedule <- list()
  schedule[[1]] <- list(id = 1, date_time = as.POSIXct("2017-04-03 15:00 EEST"), proteins_food = "meat", proteins_mass = 200)
  schedule[[2]] <- list(
    id = 2, 
    date_time = as.POSIXct("2017-04-03 16:00 EEST"), 
    proteins_food = "meat", proteins_mass = 200
  )
  
  return(schedule)  
}

#
# Tests
#

scheduler.showDay.test <- function(){
  schedule <- scheduler.getSampleSchedule()
  
  res <- scheduler.showDay(schedule, Sys.Date())
  if (length(res) != 2) writeLines("scheduler.showDay Failed") else writeLines("scheduler.showDay Pass")
  if (res[[1]]$id != "1") 
    writeLines("scheduler.showDay Failed") else writeLines("scheduler.showDay Pass")
  
}
scheduler.showDay.test()

scheduler.getEventsByDate.test <- function(){
  schedule <- scheduler.getSampleSchedule()
  
  cur_time <- Sys.time()
  #delta_t = one day
  delta_t <- 60*60*24
  
  schedule[[1]]$date_time <- cur_time
  schedule[[2]]$date_time <- cur_time + delta_t
  
  
  res <-  scheduler.getEventsByDate(schedule, as.Date(cur_time))
  if (length(res) != 1) writeLines("scheduler.getEventsByDate Failed") else writeLines("scheduler.getEventsByDate Pass")
  
  res <-  scheduler.getEventsByDate(schedule, as.Date(cur_time)+1)
  if (length(res) != 1) writeLines("scheduler.getEventsByDate Failed") else writeLines("scheduler.getEventsByDate Pass")
  
}
scheduler.getEventsByDate.test()

scheduler.getTodaysPastEvents.test <- function(){
  schedule <- scheduler.getSampleSchedule()
  
  res <-  scheduler.getTodaysPastEvents(schedule, as.POSIXct("2017-04-03 15:30 EEST"))
  if (length(res) != 1) writeLines("scheduler.getTodaysPastEvents Failed") else writeLines("scheduler.getTodaysPastEvents Pass")
  
  res <-  scheduler.getTodaysPastEvents(schedule, as.POSIXct("2017-04-03 14:59 EEST"))
  if (length(res) != 0) writeLines("scheduler.getTodaysPastEvents Failed") else writeLines("scheduler.getTodaysPastEvents Pass")
}
scheduler.getTodaysPastEvents.test()


scheduler.execEvent.test <- function(){
  schedule <- scheduler.getSampleSchedule()

  user_event <- list(
    date_time = as.POSIXct("2017-04-03 15:30 EEST"),
    exec_date_time = as.POSIXct("2017-04-03 15:20 EEST"),
    status = "all good"
  )
  
  res <-  scheduler.execEvent(schedule, 1, user_event)
  if (length(res) != 2) writeLines("scheduler.execEvent Failed") else writeLines("scheduler.execEvent Pass")
  if (res[[1]]["user_event"][[1]]$status != "all good") writeLines("scheduler.execEvent Failed") else writeLines("scheduler.execEvent Pass")
}
scheduler.execEvent.test()


scheduler.findEventsByParam.test <- function(schedule, param_name, param_value) {
  schedule <- scheduler.getSampleSchedule()

  res <- scheduler.findEventsByParam(schedule, "id", 1)
  if (length(res) != 1) writeLines("scheduler.findEventsByParam.test Failed") else writeLines("scheduler.findEventsByParam.test Pass")
  
  res <- scheduler.findEventsByParam(schedule, "proteins_food", "meat")
  if (length(res) != 2) writeLines("scheduler.findEventsByParam.test Failed") else writeLines("scheduler.findEventsByParam.test Pass")

  res <- scheduler.findEventsByParam(schedule, "date", as.Date("2017-04-03"))
  if (length(res) != 2) writeLines("scheduler.findEventsByParam.test Failed") else writeLines("scheduler.findEventsByParam.test Pass")

  #+1 days to second event
  schedule[[2]]$date_time = as.POSIXct("2017-04-04 16:00 EEST")
  
  res <- scheduler.findEventsByParam(schedule, "date", as.Date("2017-04-03"))
  if (length(res) != 1) writeLines("scheduler.findEventsByParam.test Failed") else writeLines("scheduler.findEventsByParam.test Pass")
}
scheduler.findEventsByParam.test()


scheduler.findEventPositionsByParam.test <- function(schedule, param_name, param_value) {
  schedule <- scheduler.getSampleSchedule()
  
  res <- scheduler.findEventPositionsByParam(schedule, "id", 1)
  if (all(res != c(TRUE,FALSE))) writeLines("scheduler.findEventPositionsByParam.test Failed") else writeLines("scheduler.findEventPositionsByParam.test Pass")
  
  res <- scheduler.findEventPositionsByParam(schedule, "proteins_food", "meat")
  if (all(res != c(TRUE,TRUE))) writeLines("scheduler.findEventPositionsByParam.test Failed") else writeLines("scheduler.findEventPositionsByParam.test Pass")
}
scheduler.findEventPositionsByParam.test()


