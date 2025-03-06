library(readxl)
library(tidyverse)

desmoines.raw <- read_excel("Assoc. of WA Cities Signatories/Des Moines - closed/Data/Pursuit List.xlsx")

desmoines.inci <- desmoines.raw %>%
  mutate(inciID = Incident,
         reason = Nature,
         disposition = Disposition,
         rtime = hms::as_hms(str_split_i(Reported, " ", 1)),
         rdate = mdy(str_split_i(Reported, " ", 2)),
         rdatetime = force_tz(rdate + lubridate::hms(rtime), tz="US/Pacific"),
         mo = month(rdate),
         da = day(rdate),
         yr = year(rdate)
         ) %>%
  select(inciID:yr)

demoines.notes <- list(format = "xls",
                       uoa = "incident",
                       limitations = "none known")

save.image("Assoc. of WA Cities Signatories/Des Moines - closed/desmoines.rda")

