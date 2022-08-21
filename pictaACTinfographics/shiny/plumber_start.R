library(plumber)
r <- plumb("plumber.R")
plumber::pr_run(r, port = 8000)
