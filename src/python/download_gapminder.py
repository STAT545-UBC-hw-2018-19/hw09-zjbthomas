import urllib2

# download words.txt
response = urllib2.urlopen("https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv")
data = response.read()
f = open("./data/gapminder.tsv", "w")
f.write(data)
f.close()
