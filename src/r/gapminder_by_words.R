# load libraries
suppressPackageStartupMessages(library(tidyverse))

# read TSV
gapminder <- read.table(file = './data/gapminder.tsv', sep = '\t', header = TRUE)

# read words.txt
words <- readLines("./data/words.txt") %>% 
	as.data.frame()
names(words) <- c("Words")

# select countires in words.txt
gapminder_by_words <- gapminder %>% 
	filter(country %in% words$Words) %>% 
	# group by country
	group_by(country) %>% 
	# calcuate maximum population for each country
	summarise(
		max_pop = max(pop)
	)

# save modified dataframe as RDS
saveRDS(gapminder_by_words, "./data/gapminder_by_words.rds")
