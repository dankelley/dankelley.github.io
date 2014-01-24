build:
	jekyll build --trace
	rm -rf tags/*
	mv -f _site/tags/* tags

