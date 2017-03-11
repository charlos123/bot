library(cronR)


cron.clear <- function() cron_clear(ask=FALSE)

cron.listTasks <- function() cron_ls()

cron.addTask <- function(scriptPath, scriptArgs, id, frequency, description){
	cmd <- cron_rscript(scriptPath, rscript_args = scriptArgs)
	cron_add(cmd, frequency = frequency, id = id, description = description)
}


#TODO: remove later
forRef <- function () {
		cron_clear(ask=FALSE)
		cron_ls()


		cron_ls()
		cron_clear(ask=FALSE)
		cmd <- cron_rscript("/Users/olegkondratenko/Downloads/R projects/telConnector.R", rscript_args = c("TextTakenFromArgs"))
		cron_add(cmd, frequency = 'minutely', id = 'job1', description = 'Customers')
		cron_ls()





		cron_add(cmd, frequency = 'minutely', id = 'job1', description = 'Customers')





		cron_ls()
		cron_clear(ask=FALSE)
		cmd <- cron_rscript("/Users/olegkondratenko/Downloads/R projects/script2.R", rscript_args = c("Text taken from args"))

		cron_add(cmd, frequency = 'minutely', id = 'job1', description = 'Customers')
		cron_ls()
}

