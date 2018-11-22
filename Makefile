# build all
all: histogram sort_country

# clean all
clean:
	rm -rf ./data/
	rm -r ./images/*.png
	rm -rf ./doc/

# task 1: generate histogram for words.txt
histogram: ./doc/histogram.html

# task 2: sort countiries appeared in words.txt by maximum population, and show it to map
sort_country: ./doc/sort_country.html

# task 3: visualize Makefile using makefile2dot

# download words.txt
./data/words.txt: ./src/python/download_words.py
	mkdir -p ./data/
	python $<

# generate data for histogram
./data/histogram.tsv: ./src/r/histogram.r ./data/words.txt
	Rscript $<
	
# plot histogram
./images/histogram.png: ./data/histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

# generate HTML with histogram
./doc/histogram.html: ./src/rmd/histogram.rmd ./data/histogram.tsv ./images/histogram.png
	mkdir -p ./doc/
	Rscript -e 'library(rmarkdown); render("$<", output_dir = "./doc/")'

# download gapminder
./data/gapminder.tsv: ./src/python/download_gapminder.py
	mkdir -p ./data/
	python $<
	
# convert gapminder.tsv into dataframe, modify using words.txt, and save as RDS
./data/gapminder_by_words.rds: ./src/r/gapminder_by_words.R ./data/gapminder.tsv ./data/words.txt
	Rscript $<
	
# plot reorder results using fct_reorder()
./images/reorder_by_fct.png: ./src/r/reorder_by_fct.R ./data/gapminder_by_words.rds
	Rscript $<
	rm -f Rplots.pdf
	
# download countries.geo.json
./data/countries.geo.json: ./src/python/download_geo.py
	mkdir -p ./data/
	python $<
	
# generate HTML for sorting countries
./doc/sort_country.html: ./src/rmd/sort_country.rmd ./images/reorder_by_fct.png ./data/countries.geo.json ./data/gapminder_by_words.rds
	mkdir -p ./doc/
	Rscript -e 'library(rmarkdown); render("$<", output_dir = "./doc/")'