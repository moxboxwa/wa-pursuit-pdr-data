library(tidyverse)
library(pdftools)

# Yakima (see https://stackoverflow.com/questions/78787068/how-to-parse-pdf-in-r-and-then-correctly-convert-or-extract-spaced-tabbed-pieces)

## First, construct 2019 from separate monthly pdfs ----

col.names <- "IncidentID Nature Area Agency Rtime Rdate Disposition"

jan_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/JAN_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
feb_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/FEB_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
mar_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/MAR_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
apr_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/APR_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
may_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/MAY_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
jun_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/JUNE_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
jul_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/JULY_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
aug_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/AUG_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
sep_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/SEP_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
oct_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/OCT_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")
nov_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/NOV_2019_ELUDING.pdf") %>% 
  strsplit(split = "\n")
dec_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/DEC_2019_ELUDING.pdf") %>%
  strsplit(split = "\n")


temp.2019 <- c(
  col.names,
  trimws(jan_raw[[1]][6:(length(jan_raw[[1]]) -1)]), 
  trimws(feb_raw[[1]][6:(length(feb_raw[[1]]) -1)]), 
  trimws(mar_raw[[1]][6:(length(mar_raw[[1]]) -1)]), 
  trimws(apr_raw[[1]][6:(length(apr_raw[[1]]) -1)]),
  trimws(may_raw[[1]][6:(length(may_raw[[1]]) -1)]),
  trimws(jun_raw[[1]][6:(length(jun_raw[[1]]) -1)]),
  trimws(jul_raw[[1]][6:(length(jul_raw[[1]]) -1)]),
  trimws(aug_raw[[1]][6:(length(aug_raw[[1]]) -1)]),
  trimws(sep_raw[[1]][6:(length(sep_raw[[1]]) -1)]),
  trimws(oct_raw[[1]][6:(length(oct_raw[[1]]) -1)]),
  trimws(nov_raw[[1]][6:(length(nov_raw[[1]]) -1)]),
  trimws(dec_raw[[1]][6:(length(dec_raw[[1]]) -1)])
  
)  %>%
  strsplit(" +") %>%
  lapply(head, n=7) %>% # remove complainant field when present
  lapply(paste, collapse = ",") %>%
  do.call(what = "c") %>%
  read.csv(text = ., check.names = FALSE) 


rest_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/PursuitsbyDate2020-2023.pdf") %>%
  strsplit(split = "\n")
col.names.rest <- "Idate IncidentID"

temp.rest <- c(
  col.names.rest,
  trimws(rest_raw[[1]][13:(length(rest_raw[[1]]) -1)]),
  rest_raw[[2]][4:(length(rest_raw[[2]]) -3)],
  rest_raw[[3]][4:(length(rest_raw[[3]]) -3)],
  rest_raw[[4]][4:(length(rest_raw[[4]]) -5)]
  )  %>%
  strsplit(" +") %>%
  lapply(head, n=2) %>% # remove "vehicle pursuit" fields
  lapply(paste, collapse = ",") %>%
  do.call(what = "c") %>%
  read.csv(text = ., check.names = FALSE)

incidents <- temp.2019 %>%
  mutate(Date = as.Date(Rdate, "%m/%d/%Y")) %>%
  select(IncidentID, Date) %>%
  bind_rows(temp.rest %>% 
              mutate(Date=as.Date(Idate, , "%m/%d/%Y")) %>% 
              select(-Idate)
            ) %>%
  mutate(Year = lubridate::year(Date),
         Month = lubridate::month(Date),
         Day = lubridate::day(Date))

rm(list=ls(pattern = "_raw|temp|names"))
save.image(file="County-SO-Data/Yakima/Yakima.rda")
