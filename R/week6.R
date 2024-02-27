# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)



# Data Import
citations<-stri_read_lines("../data/citations.txt", encoding="Windows-1252") # use encoding of (ISO-8859-1) in the future, most common.
citations_txt <- citations[!str_detect(citations, "^\\s*$")]
length(citations)-length(citations_txt)
mean(str_length(citations_txt))

# Data Cleaning
View(sample_n(citations_tbl,20)) #when I googled to see which pane is the "source pane" I concluded that it's the same one that i'm writing this script it, so just plopping a view on it should do what you wanted. 

citations_tbl <- tibble(line=1:length(citations_txt),cite=citations_txt) %>%
  mutate(cite=str_replace_all(cite,"[\"\']","")) %>% #could use str_remove_all instead, (also the \ in \' is not necessary )
  mutate(year=str_extract(cite,"\\d{4}")) %>% #for this project we need to as a as.integer around this line
  mutate(page_start=str_match(cite,"(\\d+)-\\d+")[,2]) %>% # also needs to be in as.integer
  mutate(pref_ref=str_detect(cite,regex("performance",ignore_case=T))) %>% #could do str_to_lower around the (cite)
  mutate(title=str_match(cite, "\\)[\\.]\\s([^\\.]+[\\.\\?!])")[,2])  %>% #This isn't all inclusive to this painful dataset, but I've wasted too much trying trying to get it right, and it's just not going to work
  mutate(first_author=str_match(cite, "^\\*?([A-Z][a-z]+,?\\s[A-Z]\\.\\s?[A-Z]?\\.?)")[,2]) # far from perfect, but the best thing I could come up with (doesn't grab last names with non-letter characters and capital characters. Additionally, for the references that are (Lname, X. words) this grabs the first letter of the "words" [atleast those are some of the flaws I found]. However, it does grab the citations that had a * at the start and the ones that didn't have a , after the last name)

sum(!is.na((citations_tbl$first_author)))

