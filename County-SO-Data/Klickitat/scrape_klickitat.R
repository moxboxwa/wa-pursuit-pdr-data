# library(googlesheets4) # only needed if data are stored in a googlesheet
# library(googledrive)
library(readxl)

# Examples to see if you can find/specify a unique folder and filename
# See: https://googledrive.tidyverse.org/reference/drive_find.html
# The googledrive functions should pop up an authorization dialog in your
# web-browser if necessary


# Read data from the downloaded file

# inci level data
klickitat.inci <- read_xlsx("County-SO-Data/Klickitat/Klickitat.xlsx")

# very few pursuits, so table was manually constructed
klickitat.tbl <- read_xlsx(
  "County-SO-Data/Klickitat/Klickitat.xlsx",
  sheet = "Table",
  skip = 2
)

save.image(file="County-SO-Data/Klickitat/Klickitat.rda")
