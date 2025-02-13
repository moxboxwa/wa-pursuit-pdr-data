library(tidyverse)
library(pdftools)

# Yakima (works, see https://stackoverflow.com/questions/78787068/how-to-parse-pdf-in-r-and-then-correctly-convert-or-extract-spaced-tabbed-pieces)

jan_raw <- pdf_text("County-SO-Data/Yakima/OriginalData/JAN_2019_ELUDING.pdf")
jan_rows <- strsplit(jan_raw, split = "\n")
incinum <- length(jan_rows[[1]]) -1

jan <- c(
  "  Incident Nature Area Agency Rdate Rtime Disposition",
  jan_rows[[1]][6:incinum]  # strips off orig col headers
  )  %>%
  strsplit(" +") %>%
  Filter(f = \(x) length(x) == 8) %>%
  lapply(paste, collapse = ",") %>%
  do.call(what = "c") %>%
  read.csv(text = ., check.names = FALSE) %>%
  select(-1)
  


# Adams

# import - creates one long chr string per page
text <- pdf_text("County-SO-Data/Adams/23-372 list of cases containing the word PURSUIT.pdf")

# split lines at \n - creates list with one element per page
text2 <- strsplit(text, "\n")
head(text2[[2]])

#df <- do.call(rbind.data.frame, text2)


text3 <- data.frame(allvars=text2[[1]][-1])
for(i in 2:3){
  text3 <- rbind(text3, data.frame(allvars=text2[[i]]))
}

text4 <- text3 %>%
  rowwise() %>%
  mutate(incident = str_split_i(allvars, "\\s+", i=1),
         nature = str_split_i(allvars, "\\s+", i=2),
         datetime = str_split_i(allvars, "\\s+", i=3))
  

