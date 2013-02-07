library(DBI)
library(RMySQL)

drv <- dbDriver("MySQL")
ch <- dbConnect(dbDriver('MySQL'), dbname='restaurant_reviews', user = 'davide', password = 'xy989dt', host = 'murnau')

