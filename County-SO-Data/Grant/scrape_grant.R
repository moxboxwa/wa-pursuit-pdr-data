library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)

rm(list=ls())

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary

drive_find("Grant County", type="folder")
#drive_get("Grant County/Grant.xlsx")


# Download an excel file from the drive
dl <- drive_download(file = "Grant County/Grant.xlsx", # google drive filename
                     path = "County-SO-Data/Grant/Grant.xlsx", # local filename
                     overwrite = TRUE, 
                     type = "xlsx")

# Read data from the downloaded file

#grant has no inci level

grant.tbl <- read_xlsx(
  "County-SO-Data/Grant/Grant.xlsx",
  sheet = "Sheet1",
  skip = 2
)

save.image(file="County-SO-Data/Grant/Grant.rda")