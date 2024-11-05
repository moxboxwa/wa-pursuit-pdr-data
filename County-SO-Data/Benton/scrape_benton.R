library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary

drive_find("Benton County", type="folder")
drive_get("Benton County/Benton.xlsx")

# Download an excel file from the drive
dl <- drive_download(file = "Benton County/Benton.xlsx", # google drive filename
                     path = "County-SO-Data/Benton/Benton.xlsx", # local filename
                     overwrite = TRUE, 
                     type = "xlsx")

# Read data from the downloaded file

benton.inci <- read_xlsx("County-SO-Data/Benton/Benton.xlsx")

benton.tbl <- read_xlsx(
  "County-SO-Data/Benton/Benton.xlsx",
  sheet = "Table",
  skip = 2
)

save.image(file="County-SO-Data/Benton/Benton.rda")

