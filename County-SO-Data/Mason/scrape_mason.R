library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary

drive_find("Mason County", type="folder")

# Download an excel file from the drive
dl <- drive_download(file = "Mason County/Mason.xlsx", # google drive filename
                     path = "County-SO-Data/Mason/Mason.xlsx", # local filename
                     overwrite = TRUE, 
                     type = "xlsx")

# Read data from the downloaded file

#mason has no inci level

mason.tbl <- read_xlsx(
  "County-SO-Data/Mason/Mason.xlsx",
  skip = 2
)

save.image(file="County-SO-Data/Mason/Mason.rda")