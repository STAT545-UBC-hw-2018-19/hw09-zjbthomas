import urllib2

# download words.txt
response = urllib2.urlopen("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co")
data = response.read()
f = open("./data/words.txt", "w")
f.write(data)
f.close()
