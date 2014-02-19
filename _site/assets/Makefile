thumbnails: pisa-scores-thumbnail.png webtide1-thumbnail.png webtide2-thumbnail.png \
    colorline-thumbnail.png webtideosx1-thumbnail.png webtideosx2-thumbnail.png \
    sundial_with_gnomon-thumbnail.png analemma-thumbnail.png \
    coastline-switch-1-thumbnail.png coastline-switch-2-thumbnail.png \
    vote-split-thumbnail.png smooth-profile-thumbnail.png \
    solstice_sunrise_sunset-thumbnail.png gmt-topography-thumbnail.png \
    gmt_relief_2-thumbnail.png splines-thumbnail.png splines2-thumbnail.png \
    2014-02-19-filtfilt_octave-thumbnail.png

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
solstice_sunrise_sunset-thumbnail.png: force
	/usr/local/bin/convert -thumbnail 400x400 solstice_sunrise_sunset.png solstice_sunrise_sunset-thumbnail.png;
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


force:

%.md: %.Rmd
	Rscript -e 'source(paste(getwd(),"/knitPost.R",sep="")); knitPost("$<", "{{ site.url }}/assets/")'
	mv $@ ../_posts/


oar-toc: force
	-/usr/local/bin/convert -resize 45% oar-toc-1.png tmp.png
	-mv tmp.png oar-toc-1.png
	-/usr/local/bin/convert -resize 45% oar-toc-2.png tmp.png
	-mv tmp.png oar-toc-2.png
