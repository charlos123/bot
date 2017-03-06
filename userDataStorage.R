
uds.createSampleUserData <- function(){
		
	dish <- list(name = "perlovka", weight = 150)

	taking <- list(takingNum = 1, dishes =list(dish, dish))

	userTaking1 <- list(
						id = 1,
						#taking id of a given day
						takingId = 1, 
						loggedTime = Sys.time(), 
						execTime = Sys.time(),
						asPlanned = TRUE,
						dishesTaken = list(dish, dish)
					)

	userTaking2 <- list(
						id = 2,
						takingId = 1, 
						loggedTime = Sys.time(), 
						execTime = Sys.time(),
						asPlanned = FALSE,
						dishesTaken = list(dish, dish)
					)

	userTaking3 <- list(
						id = 3,
						#not connected to particular taking
						takingId = NULL, 
						loggedTime = Sys.time(),
						execTime = Sys.time(),
						#should always be FALSE if scheduleTakingNum == NULL
						asPlanned = FALSE,
						dishesTaken = list(dish, dish)
					)
	
	userData <- list(
			id = 123,
			name = "Oleg",
			globalTarget = "weight == 83",
			# TODO: later use it for lazy loading - always load avalableDates and loadCalendar on request
			# position in availableDates is the same as position calendar.list 
			availableDates = c(Sys.Date()),
			calendar = list(
				list(
					date = Sys.Date(),
					# all other params contain only events for a given day
					physicalParams = list(), 
					plannedTakings = list(taking, taking),
					userTakings = list(userTaking1, userTaking2, userTaking3),
					phisicalActivities = list()
				)
			)
		)
	
	return(userData)	
}


uds.loadUserDataById <- function(id){
	return(uds.createSampleUserData())
}

