library(cronR)


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


