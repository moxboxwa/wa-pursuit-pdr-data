rm(list=ls())
library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary


# Read data from the local file - only 6 incidents so we don't make the table

pacific.inci <- read_xlsx("County-SO-Data/Pacific/Pacific.xlsx")
  
save.image(file="County-SO-Data/Pacific/Pacific.rda")
