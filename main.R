## init bot, todaysTakings, etc
source("initGlobals.R")

## cron API
source("cron.R")


## read todaysTriggers for user
todaysTriggers <- list(
		list(
			id = 1,
			time = Sys.time()+60
		),
		list(
			id = 2,
			time = Sys.time()+30
		)

	)


notifierTaskPath <- "/Users/olegkondratenko/Downloads/R projects/notifierTask.R"


## clearing cron tasks
## TODO: read for all users at midnight
## WARNING: potential issues with timezones
cron.clear()

## create cron tasks for todaysTakings
triggerInfo <- todaysTriggers[[1]]

cron.addTask(
	scriptPath = notifierTaskPath, 
	#will be used to find a trigger
	scriptArgs = c(triggerInfo$id),
	#will be used to manage cron tasks	
	id = triggerInfo$id, 
	frequency = 'minutely', 
	description = paste0("id=", triggerInfo$id, " time=", triggerInfo$time))

cron.listTasks()


ls() == "y"
match("qq", ls())
