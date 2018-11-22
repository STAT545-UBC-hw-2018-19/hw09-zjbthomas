import urllib2

# download countries.geo.json
response = urllib2.urlopen("https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json")
data = response.read()
f = open("./data/countries.geo.json", "w")
f.write(data)
f.close()
