library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary

#drive_find("Asotin County", type="folder")
#drive_get("Asotin County/Asotin.xlsx")

# Download an excel file from the drive
dl <- drive_download(file = "Asotin County/Asotin.xlsx", # google drive filename
                     path = "County-SO-Data/Asotin/Asotin.xlsx", # local filename
                     overwrite = TRUE, 
                     type = "xlsx")

# Read data from the downloaded file
# KC gave us incident-based data, so we have both that and the pivot table

# have not got this far yet for asotin king.inci <- read_xlsx("County-SO-Data/King/King.xlsx")

#king.tbl <- read_xlsx(
#  "County-SO-Data/King/King.xlsx",
#  sheet = "Table",
#  skip = 2
#)
  
save.image(file="County-SO-Data/King/King.rda")