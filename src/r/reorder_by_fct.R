# load libraries
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(forcats))

# read RDS
gapminder_by_words <- readRDS("./data/gapminder_by_words.rds")

# make plot
plot <- gapminder_by_words %>%
	# show preview of resultant levels
	ggplot(aes(x = max_pop, y = fct_reorder(country, max_pop, max), color = country)) +
	# make it a scatterplot
	geom_point() + 
	# scale x axis by log10
	scale_x_log10() +
	# change axis labels
	xlab("Maximum population") +
	ylab("country") +
	# add title
	labs(title = "Maximum population of countries in Americas") +
	# change theme
	theme_bw()

# save image
ggsave("./images/reorder_by_fct.png", plot = plot, device = "png")