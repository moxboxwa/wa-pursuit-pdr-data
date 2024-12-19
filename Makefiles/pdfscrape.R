library(tidyverse)
library(pdftools)



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
  

