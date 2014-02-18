%.md: %.Rmd
	Rscript -e 'source(paste(getwd(),"/knitPost.R",sep="")); knitPost("$<", "{{ site.url }}/assets/")'
	cp *filt*png ../assets/

