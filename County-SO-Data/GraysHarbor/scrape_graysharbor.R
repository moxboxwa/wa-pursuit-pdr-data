library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

rm(list=ls())
# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary

#drive_find("Asotin County", type="folder")
#drive_get("Asotin County/Asotin.xlsx")

# Download an excel file from the drive
dl <- drive_download(file = "Grays Harbor County/GraysHarbor.xlsx", # google drive filename
                     path = "County-SO-Data/Grays Harbor/GraysHarbor.xlsx", # local filename
                     overwrite = TRUE, 
                     type = "xlsx")

# Read data from the downloaded file
graysharbor.inci <- read_xlsx("County-SO-Data/GraysHarbor/GraysHarbor.xlsx")

graysharbor.tbl <- read_xlsx(
  "County-SO-Data/GraysHarbor/GraysHarbor.xlsx",
  sheet = "Table",
  skip = 3
)

save.image(file="County-SO-Data/GraysHarbor/Grays Harbor.rda")