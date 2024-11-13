library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

rm(list=ls())

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary

drive_find("Benton County", type="folder")
drive_get("Benton County/Benton.xlsx")

# Download an excel file from the drive
dl <- drive_download(file = "WSP/WSP.xlsx", # google drive filename
                     path = "County-SO-Data/WSP/WSP.xlsx", # local filename
                     overwrite = TRUE, 
                     type = "xlsx")

# Read data from the downloaded file

wsp.inci <- read_xlsx("County-SO-Data/WSP/WSP.xlsx")

wsp.tbl <- read_xlsx(
  "County-SO-Data/WSP/WSP.xlsx",
  sheet = "Table",
  skip = 2
)

save.image(file="County-SO-Data/WSP/WSP.rda")