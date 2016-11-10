# make 2016-10-10-election-usa-2016.md
thumbnails: pisa-scores-thumbnail.png webtide1-thumbnail.png webtide2-thumbnail.png \
    colorline-thumbnail.png webtideosx1-thumbnail.png webtideosx2-thumbnail.png \
    sundial_with_gnomon-thumbnail.png analemma-thumbnail.png \
    coastline-switch-1-thumbnail.png coastline-switch-2-thumbnail.png \
    vote-split-thumbnail.png smooth-profile-thumbnail.png \
    gmt-topography-thumbnail.png \
    gmt_relief_2-thumbnail.png splines-thumbnail.png splines2-thumbnail.png \
    2014-02-19-filtfilt_octave-thumbnail.png \
    2014-02-21-oce-translations-thumbnail.png \
    2014-01-15-colourizing-along-a-trajectory.png

translation: force
	for tran in adp-de.pdf adp-en.pdf adp-es.pdf adp-fr.pdf adp-zh.pdf adv-de.pdf adv-en.pdf adv-es.pdf adv-fr.pdf adv-zh.pdf cm-de.pdf cm-en.pdf cm-es.pdf cm-fr.pdf cm-zh.pdf ctd-de.pdf ctd-en.pdf ctd-es.pdf ctd-fr.pdf ctd-zh.pdf drifter-de.pdf drifter-en.pdf drifter-es.pdf drifter-fr.pdf drifter-zh.pdf lisst-de.pdf lisst-en.pdf lisst-es.pdf lisst-fr.pdf lisst-zh.pdf lobo-de.pdf lobo-en.pdf lobo-es.pdf lobo-fr.pdf lobo-zh.pdf sealevel-de.pdf sealevel-en.pdf sealevel-es.pdf sealevel-fr.pdf sealevel-zh.pdf section-de.pdf section-en.pdf section-es.pdf section-fr.pdf section-zh.pdf tdr-de.pdf tdr-en.pdf tdr-es.pdf tdr-fr.pdf tdr-zh.pdf ; do \
	    echo $$tran ; \
	    /usr/local/bin/convert -density 150 $$tran `basename $$tran .pdf`.png ; \
	    /usr/local/bin/convert -thumbnail 100x100 $$tran `basename $$tran .pdf`-thumbnail.png ; \
	    done

pisa-scores-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 pisa-scores.png pisa-scores-thumbnail.png;
webtide1-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 webtide1.png webtide-thumbnail1.png;
webtide2-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 webtide2.png webtide-thumbnail2.png;
webtideosx1-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 webtideosx1.png webtideosx1-thumbnail.png;
webtideosx2-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 webtideosx2.png webtideosx2-thumbnail.png;
colorline-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 colorline.png colorline-thumbnail.png;
sundial_with_gnomon-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 sundial_with_gnomon.png sundial_with_gnomon-thumbnail.png;
analemma-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 analemma.png analemma-thumbnail.png;
coastline-switch-1-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 coastline-switch-1.png coastline-switch-1-thumbnail.png;
coastline-switch-2-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 coastline-switch-2.png coastline-switch-2-thumbnail.png;
vote-split-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 vote-split.png vote-split-thumbnail.png;
smooth-profile-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 smooth-profile.png smooth-profile-thumbnail.png;
gmt-topography-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 gmt-topography.png gmt-topography-thumbnail.png
gmt_relief_2-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 600x600 gmt_relief_2.png gmt_relief_2-thumbnail.png
splines-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 600x600 splines.png splines-thumbnail.png
splines2-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 600x600 splines2.png splines2-thumbnail.png
2014-02-19-filtfilt_octave-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 600x600 2014-02-19-filtfilt_octave.png 2014-02-19-filtfilt_octave-thumbnail.png
2014-02-21-oce-translations-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 600x600 2014-02-21-oce-translations.png 2014-02-21-oce-translations-thumbnail.png

force:

%.md: %.Rmd
	#Rscript -e 'source(paste(getwd(),"/knitPost.R",sep="")); knitPost("$<", "{{ site.url }}/assets/")'
	-Rscript -e 'source(paste(getwd(),"/knitPost.R",sep="")); knitPost("$<")'
	-mv $@ ../_posts/
	#mv figs/`basename $@ .md` ../_site/figs
	#Next line added 2014-12-13 to get figure inclusion in the 2013*solstice entry
	-rm -rf ../figs/`basename $@ .md`
	-mv figs/`basename $@ .md` ../figs
	echo "Now cd .. ; make ; git add . ; git commit -m . ; git push"


oar-toc: force
	-/usr/local/bin/convert -resize 45% oar-toc-1.png tmp.png
	-mv tmp.png oar-toc-1.png
	-/usr/local/bin/convert -resize 45% oar-toc-2.png tmp.png
	-mv tmp.png oar-toc-2.png

md:2014-01-15-colourizing-along-a-trajectory.md 2014-01-30-gmt-colors-topography.md 2014-02-08-hodograph.md 2014-02-10-oce-map-projection.md 2014-02-11-oce_runlm.md 2014-02-13-valentine-moon.md 2014-02-17-demodulation.md 2014-02-19-filtfilt.md 2014-03-05-error-bars-in-r.md 2014-03-12-digitizing-plots.md 2014-03-16-box-model.md 2014-03-22-sun-moon.md 2014-04-12-memoise.md 2014-04-30-colormap.md 2014-06-08-Rcpp.md 2014-06-08-slumping-model.md 2014-06-22-gulf-stream-center.md 2014-11-10-solar-navigation.md
