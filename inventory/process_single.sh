#!/bin/bash

URL=$1
FILENAME=$2
echo " Creating: ${FILENAME}"
webkit2png --ignore-ssl-check -C --delay=2 --clipwidth=300 --clipheight=300 ${URL} -o "./images/${FILENAME}"
mv "./images/${FILENAME}-clipped.png" "./images/${FILENAME}.png"
convert ./images/${FILENAME}.png \
    -gravity South   -background White  -splice 0x40 \
    -fill Black -draw 'line 0,600 600,600' \
    -pointsize 18 -annotate +0+2 "$FILENAME" \
    -gravity Center -append ./images/${FILENAME}.png
echo ""

