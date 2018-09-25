URL=nonsns.github.io

all: bundle

bundle: papersync bundlebuild 

#------------ a bit out of place here ? ----------------
#------------ should make it more clear ----------------
#------------ and more generic for all sources ---------
bib:
	(cd _bibliography; make)
	cp -u ~/paper/PDF/*pdf paper


#-------------------- dependencies ---------------------
gem:
	sudo bundle install

#-------------------- update paper ---------------------
papersync:
	echo "should make this stub for github"
	#(cd $(HOME)/paper/PDF; make copy)	


#---------------------- compile ------------------------
trace:
	bundle exec jekyll server --trace

build:	
	jekyll build -V
	#done in 175.667 seconds.????

bundletest:
	bundle exec jekyll serve --watch

test:
	jekyll serve --watch

fastbuild:	
	jekyll build --incremental -V

bundlebuild:	
	bundle exec jekyll build --incremental -V




#------------------------ github -------------------------
github:
		rsync -av --size-only _site/ ../nonsns.github.io
		(cd ../nonsns.github.io; git commit -a -m "autobuild $(date)"; git push)



#------------------------ check -------------------------
# link checker -- 
lcheck:
	linkchecker $(URL)

permalink:
	find | grep .md  | xargs grep --color permalink | column -t
