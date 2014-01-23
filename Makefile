build:
	jekyll build --trace
	rm -rf tags/*
	mv _site/tags/* ./tags

