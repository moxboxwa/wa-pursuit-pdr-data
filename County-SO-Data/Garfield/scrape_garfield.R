library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary
rm(list=ls())


#converted data from email pdf into table and saved in computer
#  no inci level

garfield.tbl <- read_xlsx(
  "County-SO-Data/Garfield/Garfield.xlsx",
  skip = 2
)

save.image(file="County-SO-Data/Garfield/Garfield.rda")