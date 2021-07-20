###################### Mueller report #######################
# Step 1 - Download the report.
curl -o report.pdf https://www.justice.gov/storage/report.pdf
# OOPS. Nothing gets downloaded. That is because the report redirects to another URL. 
# We use a flag to solve that problem. -L makes sure curl picks the redirected file.
curl -L -o report.pdf https://www.justice.gov/storage/report.pdf

# Now we have the report, so on to step 2

# Turn all pages into pngs
magick convert report.pdf -resize 25% report-%03d.png

# Turn it to a montage
magick montage -tile 15x0 -geometry +0+0 report*.png grid-withgeo.png

# Or a gif! Maybe the pages should be bigger for that?
convert -density 72 report.pdf -resize 50% -background white -alpha remove -alpha off report-bigger-%03d.png
convert -delay 20 report-bigger*.png -loop 0  animate.gif
