# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(stringr)
library(tidyverse)


# Data Import
citations<-stri_read_lines("../data/citations.txt", encoding="Windows-1252") # I chatgpted the encoding code
citations_txt <- citations[!str_detect(citations, "^\\s*$")]
length(citations)-length(citations_txt)
mean(str_length(citations_txt))

# Data Cleaning


citations_tbl <- tibble(line=1:length(citations_txt),cite=citations_txt) %>%
  mutate(cite=str_replace_all(citations_tbl$cite,"[\"\']","")) %>%
  mutate(year=str_extract(citations_tbl$cite,"\\d{4}")) %>%
  mutate(page_start=str_match(citations_tbl$cite,"(\\d+)-\\d+")[,2]) %>%
  mutate(pref_ref=str_detect(citations_tbl$cite,regex("performance",ignore_case=T))) %>%
  mutate(title=str_match(citations_tbl$cite, "\\)[\\.]\\s([^\\.]+[\\.\\?!])")[,2])  %>% #This isn't all inclusive to this painful dataset, but I've wasted too much trying trying to get it right, and it's just not going to work
  mutate(first_author=str_match(citations_tbl$cite, "^\\*?([A-Z][a-z]+,?\\s[A-Z]\\.\\s?[A-Z]?\\.?)")[,2]) # far from perfect, but the best thing I could come up with (doesn't grab last names with non-letter characters and capital characters [atleast those are some of the flaws I found])



