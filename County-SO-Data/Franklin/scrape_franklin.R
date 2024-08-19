library(googlesheets4) # only needed if data are stored in a googlesheet
library(googledrive)
library(readxl)


#I converted the PDF on google drive into an excel on my computer

#franklin has no inci level
franklin.tbl <- read_xlsx("County-SO-Data/Franklin/Franklin.xlsx")



save.image(file="County-SO-Data/Franklin/Franklin.rda")