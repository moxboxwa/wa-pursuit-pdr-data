library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

rm(list=ls())

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary


# Read data from the *repo* file, not the google drive
# inci level data transcribed from the correspondence, just month and year

ferry.inci <- read_xlsx(
  "County-SO-Data/Ferry/Ferry.xlsx")

ferry.table <- read_xlsx(
  "County-SO-Data/Ferry/Ferry.xlsx",
  sheet = "Table"
)

save.image(file="County-SO-Data/Ferry/Ferry.rda")