source("userDataStorage.R")
require(uuid)
library(dplyr)

#gs df structure consts
options(
  df.dishes_offset = 1,
  df.max_dishes = 4,
  df.dish_components = 2)



dishesOffset <- getOption("df.dishes_offset")
maxDishes <- getOption("df.max_dishes")
dishComponents <- getOption("df.dish_components")

updatePlannedTakingsFromGS <- function(userData, date){
	#load takings from df
	schedule.df <- gsLoader.loadScheduleData2Df()

	getListOfListOfDishPairs <- function(aTaking){
		names <- aTaking %>% select((1+dishesOffset):(dishesOffset+maxDishes)) %>% sapply(as.character) %>% na.omit() %>% as.vector 
		weights <- aTaking %>% select((dishesOffset+maxDishes):(dishesOffset+2*maxDishes)) %>% sapply(as.character) %>% na.omit() %>% as.vector 

		lapply(1:length(names), function(x) list(name=names[x], weight= weights[x]))
	}



	#if date is not in availableDates we add it to the vector
	#note: expect to find only one matching
	if(is.na(match(theDate, userData$availableDates))) 
		userData$availableDates <- append(userData$availableDates, theDate)


	calendarItem <- userData$calendar[[match(theDate, userData$availableDates)]]
	#overwrite date of the calendar (might be missing)
	calendarItem$date <- theDate
	calendarItem$plannedTakings <- lapply(schedule.df$takingNum, function(x) list( takingNum = x, dishes = getListOfListOfDishPairs(schedule.df[x,])))

	userData$calendar[[match(theDate, userData$availableDates)]] <- calendarItem

	return(userData)
}


	userData <- uds.loadUserDataById(1)

	theDate <- Sys.Date()

	userData <- updatePlannedTakingsFromGS(userData, theDate)

	userData$calendar[[1]]$plannedTakings



#taking$dishes <- getListOfListOfDishPairs(schedule.df[1,])




