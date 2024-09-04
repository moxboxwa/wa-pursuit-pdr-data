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
dl <- drive_download(file = "Clallam County/Clallam.xlsx", # google drive filename
                     path = "County-SO-Data/Clallam/Clallam.xlsx", # local filename
                     overwrite = TRUE, 
                     type = "xlsx")

# Read data from the downloaded file
clallam.inci <- read_xlsx("County-SO-Data/Clallam/Clallam.xlsx")

clallam.tbl <- read_xlsx(
  "County-SO-Data/Clallam/Clallam.xlsx",
  sheet = "Table",
  skip = 2
)

save.image(file="County-SO-Data/Clallam/Clallam.rda")