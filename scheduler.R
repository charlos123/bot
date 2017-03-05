scheduler.showDay <- function(schedule, date) {
  writeLines(paste("This is schedule for", format(date, "%u"), "day of the week"))
  
  #print the whole day
  lapply( schedule, function(x) { writeLines(paste(names(x), "=", x, collapse=", "))  })
  
  # as.Date as date_and_time can be passed
  res <- scheduler.findEventsByParam(schedule, "date", as.Date(date))
  
  return(res)
}

scheduler.getEventsByDate <- function(schedule, date) {
  ve <- sapply(schedule, function(x) as.Date(x[["date_time"]])) == date
  
  return(schedule[ve])
}

scheduler.findEventsByParam <- function(schedule, param_name, param_value) {
  #note:only non-list params are allowed
  ve <- scheduler.findEventPositionsByParam(schedule, param_name, param_value)
  return(schedule[ve])
}

scheduler.findEventPositionsByParam <- function(schedule, param_name, param_value) {
  #note:only non-list params are allowed
  ve <- NULL
  if (param_name == "date"){
    ve <- sapply(schedule, function(x) as.Date(x[["date_time"]])) == param_value
  }else{
    ve <- sapply(schedule, function(x) x[[param_name]]) == param_value
  }

  return(ve)
}

scheduler.execEvent <- function(schedule, schedule_event_id, user_event) {
  v <- scheduler.findEventPositionsByParam(schedule, "id", schedule_event_id)
  
  #expect to find only one element
  schedule[v][[1]]$user_event <- user_event

  return(schedule)
}

scheduler.getTodaysPastEvents <- function(schedule, date_time){
  event_times <-lapply(scheduler.getEventsByDate(schedule, as.Date(date_time)), function(x) x[["date_time"]])
  
  return(schedule[difftime(do.call(c, event_times), date_time) <= 0])
}


