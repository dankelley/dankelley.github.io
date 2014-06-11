build:
	rm -rf tags/*
	jekyll build --trace
	mv -f _site/tags/* tags
	mv -f _site/assets/figs/* figs
serve: force
	jekyll serve --watch
clean:
	-rm *~ */*~ */*/*~
force:

