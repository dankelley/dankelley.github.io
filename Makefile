build:
	rm -rf tags/*
	jekyll build --trace
	mv -f _site/tags/* tags
serve: force
	jekyll serve --watch
clean:
	-rm *~ */*~ */*/*~
force:

