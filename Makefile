build:
	rm -rf tags/*
	jekyll build --trace
	mv -f _site/tags/* tags
clean:
	-rm *~ */*~ */*/*~

