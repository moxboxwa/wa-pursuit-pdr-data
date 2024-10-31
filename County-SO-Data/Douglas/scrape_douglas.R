library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary

rm(list=ls())

# Download an excel file from the drive
dl <- drive_download(file = "Douglas County/Douglas.xlsx", # google drive filename
                     path = "County-SO-Data/Douglas/Douglas.xlsx", # local filename
                     overwrite = TRUE, 
                     type = "xlsx")

# Read data from the downloaded file

#does not have incident level data
# douglas.inci <- read_xlsx("County-SO-Data/Douglas/Douglas.xlsx")

douglas.tbl <- read_xlsx(
  "County-SO-Data/Douglas/Douglas.xlsx",
  sheet = "Table",
  skip = 2
)

save.image(file="County-SO-Data/Douglas/Douglas.rda")