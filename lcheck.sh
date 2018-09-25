#! /bin/bash

#bad:
#	wget  -r --spider https://perso.telecom-paristech.fr/drossi | tee _ignore/spider.results
#good, interactive:
# 	linkchecker https://perso.telecom-paristech.fr/drossi

threads=100

if [[ $1 == "" ]]
then
	echo "Checking /"
	linkchecker \
		-t${threads} \
		-Ftext/ascii/_ignore/linkchecker.out \
		https://perso.telecom-paristech.fr/drossi/
elif [[ $1 == "-" ]]
then	
	grep ^URL _ignore/linkchecker.out   | sort | uniq -c | sort -n 

	echo "Total"
	grep ^URL _ignore/linkchecker.out   | sort | uniq -c | sort -n | wc
	exit

else
	echo "Checking $1"
	linkchecker \
		-t${threads} \
		-r1 \
		-Ftext/ascii/_ignore/linkchecker.out \
		https://perso.telecom-paristech.fr/drossi/$1
fi			

 	
grep ^URL _ignore/linkchecker.out   | sort | uniq -c | sort -n 

echo "Total"
grep ^URL _ignore/linkchecker.out   | sort | uniq -c | sort -n | wc
