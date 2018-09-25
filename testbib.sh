for k in 2018; do
	cat $HOME/seminar/bibtex/$k.bib | perl -pe '
	s/biography\s*=\s*{/note = {/;
    s/author\s*=\s*\{(.*)\s*\((.*)\)\s*}\s*,/author = {$1},\naffiliation = {$2},/;
	' 
done	

#  s/author\s*=\s*\{(.+)\s*\((.+)\)\},/author = {$1},\naffiliation = {$2},/;
