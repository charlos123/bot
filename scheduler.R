

scheduler.showDay <- function(schedule, req_date) {
  writeLines(paste("This is schedule for", format(req_date, "%u"), "day of the week"))
  
  #print the whole day
  lapply( schedule, function(x) { writeLines(paste(names(x), "=", x, collapse=", "))  })
  
  #return events of a given day
  #FIXIT: now returns all events
  return(schedule)
}

scheduler.getEventsByDate <- function(schedule, date) {
  ve <- sapply(schedule, function(x) x[["date"]]) == "04/03/2017"
  return(schedule[ve])
}

scheduler.getTodaysPastEvents <- function(schedule, date, time){
   # TODO: switch to Date and Time in Schedule
  ve <- difftime(sapply(scheduler.getEventsByDate(schedule), function(x) x[["time"]]) <= time
  return(schedule[ve])
}


#
# Sample Data
#
scheduler.getSampleSchedule <- function(){
  schedule <- list()
  schedule[[1]] <- list(id = 1, date = format(Sys.Date(),"%d/%m/%Y"), time = format(Sys.time(),"%H:%M"), proteins_food = "meat", proteins_mass = 200)
  #adding 3 seconds to time of first event
  schedule[[2]] <- list(
    id = 2, 
    date = format(Sys.Date(),"%d/%m/%Y"), 
    time = format(Sys.time()+3,"%H:%M:%S"), 
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

schedule.getEventsByDate.test <- function(){
  schedule <- scheduler.getSampleSchedule()
  
  schedule[[1]]$date <- "04/03/2017"
  schedule[[2]]$date <- "05/03/2017"
  
  
  res <-  scheduler.getEventsByDate(schedule, "04/03/2017")
  if (length(res) != 1) writeLines("scheduler.getEventsByDate Failed") else writeLines("scheduler.getEventsByDate Pass")
  
  res <-  scheduler.getEventsByDate(schedule, "05/03/2017")
  if (length(res) != 1) writeLines("scheduler.getEventsByDate Failed") else writeLines("scheduler.getEventsByDate Pass")
  
}

scheduler.getTodaysPastEvents.test <- function(){
  schedule <- scheduler.getSampleSchedule()

  schedule[[1]]$time <- "15:00"
  schedule[[1]]$date <- "04/03/2017"

  schedule[[2]]$time <- "16:00"
  schedule[[2]]$date <- "04/03/2017"
  
    
  res <-  scheduler.getTodaysPastEvents(schedule, "04/03/2017", "15:01")
  if (length(res) != 1) writeLines("scheduler.getTodaysPastEvents Failed") else writeLines("scheduler.getTodaysPastEvents Pass")
  
  res <-  scheduler.getTodaysPastEvents(schedule, "04/03/2017", "14:58")
  if (length(res) != 0) writeLines("scheduler.getTodaysPastEvents Failed") else writeLines("scheduler.getTodaysPastEvents Pass")
}


scheduler.showDay.test()
schedule.getEventsByDate.test()
scheduler.getTodaysPastEvents.test()

