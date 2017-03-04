source("scheduler.R")

#
# util funcitons
#

util.getInput <- function(message) {
  out <- readline(paste0(message," "))
  return(out)
}

#finds if word is in a list of keywords and executes "its" function
util.runOperatorsByKeyword <- function(userdata, operators, kw, message) {
  for(i in 1:length(operators)){
    if (kw %in% operators[[i]]$keywords)
      userdata <- do.call(operators[[i]]$runFunction, list(userdata, message))
  }
    
  return(userdata)
}

#adds operator ot a list of operators bot works with
util.appendOper <- function(opers, kws, func){
  opers[[length(opers)+1]] <- 
    list(
      keywords = kws, 
      runFunction = func
    )
  return(opers)
}

#
# End of util funcitons
#


#init operators
operators <- list()

#init user's data
userdata <- list()


#
# runNewsOperator - shows news on demand
#
runNewsOperator.keywords <- c("news", "updates", "whatsup")
runNewsOperator.trace <- c("news")

runNewsOperator <- function(udata, message = ""){
  
  newsfeeder.showNews <- function(){
    writeLines("This is a news")
  }
  
  if (util.getInput("show some news? y/n") == "y"){
    newsfeeder.showNews()
    if (util.getInput("like it? y/n") == "y"){
      writeLines("I like you like it")
      runNewsOperator(udata)
    } else
      "Sorry, man"
  }
  
  # last thing for operator - updating and returning userData
  # operatorUserDate list(trace,interactions(list))
  # TODO: track interactions - no updates for now to userData
  #operatorUserData <- list(trace = morningHidrationOperator.trace, interactions = interactions)
  #udata[[length(udata)+1]] <- operatorUserData   
  return(udata)
}


#
# wti (what to eat) - shows eating schedule for a given day
#
wti.keywords <- c("wti")
wti.trace <- c("wti")

wti <- function(udata, message = ""){
  schedule <- scheduler.getSampleSchedule()

  dayAnswer <- util.getInput("for today? y/day_of_this_week")
  
  if(dayAnswer == "y") {
    scheduler.showDay(schedule, Sys.Date())
  }else if (dayAnswer %in% -7:7){
    req_date <- as.Date(format(Sys.Date(),paste0("%Y-%W-",dayAnswer)), "%Y-%W-%u")
    scheduler.showDay(schedule, req_date)
  }else{
    writeLines("Sorry, don't understand. Quit wti...")
  }
  
  # last thing for operator - updating and returning userData
  # operatorUserDate list(trace,interactions(list))
  # TODO: track interactions - no updates for now to userData
  #operatorUserData <- list(trace = morningHidrationOperator.trace, interactions = interactions)
  #udata[[length(udata)+1]] <- operatorUserData   
  return(udata)
}


#
# morningHidrationOperator - shows news on demand
#
morningHidrationOperator.keywords <- c("hidr")
morningHidrationOperator.trace <- c("hidr")

morningHidrationOperator <- function(udata, message = ""){
  #init interactions
  interactions <- list()

  writeLines("Hidration is imortant to stay energized and motivated")
  writeLines("Drinking as a first thing in a morning starts your engine")
  writeLines("It's easy you just need to get used to it")
  
  if (util.getInput("want to make this habbit? y/n") == "y"){
      interactions[[length(interactions)+1]] <- list(action = "want to make this habbit?", reaction = "y")
      
      writeLines("great! It's easy. we'll help you track you do it every time you wake up")

      if (util.getInput("can we remind you when you wake up? y/n") == "y"){
        interactions[[length(interactions)+1]] <- list(action = "can we remind you when you wake up?", reaction = "y")
        
        writeLines("we'll remind you at 7:00")

        #runNewsOperator()
        
      }else{
        interactions[[length(interactions)+1]] <- list(action = "can we remind you when you wake up?", reaction = "n")
        writeLines("Okay, just check your TODO list and mark what's completed")
      }
  }else{
    interactions[[length(interactions)+1]] <- list(action = "want to make this habbit?", reaction = "n")

    writeLines("I'll propose you sometimes later")
  }

  # last thing for operator - updating and returning userData
  # operatorUserDate list(trace,interactions(list))
  operatorUserData <- list(trace = morningHidrationOperator.trace, interactions = interactions)
  udata[[length(udata)+1]] <- operatorUserData   
  return(udata)
}


  
#collect operators
operators <- util.appendOper(operators, runNewsOperator.keywords, runNewsOperator)
operators <- util.appendOper(operators, morningHidrationOperator.keywords, morningHidrationOperator)
operators <- util.appendOper(operators, wti.keywords, wti)
operators


#
# Main
#

while (TRUE){
  message = util.getInput("Wanna smth?")
  userdata  <- util.runOperatorsByKeyword(userdata, operators, kw = message, message = message) 

  if (message == "q") break
}

