# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(stringr)




# Data Import
citations<-stri_read_lines("../data/citations.txt", encoding="Windows-1252") # I chatgpted the encoding code
citation_txt <- citations[!str_detect(citations, "^\\s*$")]

