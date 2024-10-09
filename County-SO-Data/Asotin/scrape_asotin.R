rm(list=ls())
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

asotin.inci <- read_xlsx("County-SO-Data/Asotin/Asotin.xlsx",
                         skip = 1)

asotin.tbl <- read_excel("County-SO-Data/Asotin/Asotin.xlsx", 
                         sheet = "Table", 
                         skip = 3, 
                         n_max = 5)

rm("dl")
save.image(file="County-SO-Data/Asotin/Asotin.rda")
