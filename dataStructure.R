
source("gsLoader.R")

schedule.df <- gsLoader.loadScheduleData2Df()

summary(schedule.df)

names(schedule.df)



dish <- list(name = "perlovka", weight = 150)

taking <- list(id = 1, date_time = Sys.Date(), dishes =list(dish, dish))

oneDaySchedule <- list(date = Sys.Date(), takings = list(taking, taking))


userTaking1 <- list(
					#taking number of a given day
					takingId = 1, 
					loggedTime = Sys.time(), 
					execTime = Sys.time(),
					asPlanned = TRUE,
					dishesTaken = list(dish, dish)
				)

userTaking2 <- list(
					takingId = 1, 
					loggedTime = Sys.time(), 
					execTime = Sys.time(),
					asPlanned = FALSE,
					dishesTaken = list(dish, dish)
				)

userTaking3 <- list(
					#not connected to particular taking
					takingId = NULL, 
					loggedTime = Sys.time(),
					execTime = Sys.time(),
					#should always be FALSE if scheduleTakingNum == NULL
					asPlanned = FALSE,
					dishesTaken = list(dish, dish)
				)


userTakings <- list(userTackings = list(userTaking1, userTaking2, userTaking3))

userData <- list(
		name = "Oleg",
		globalTarget = "weight == 83",
		calendar = list(
				date = Sys.Date(),
				# all other params contain only events for a given day
				physicalParams = list(), 
				schedule = list(oneDaySchedule),
				userTakings = userTakings,
				phisicalActivities = list()
			)
	)
