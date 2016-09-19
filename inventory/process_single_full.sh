#!/bin/bash

URL=$1
FILENAME=$2
echo " Creating: ${FILENAME}"
webkit2png --ignore-ssl-check -F --delay=1 --width=1024 ${URL} -o "./fullsize/${FILENAME}"
mv "./fullsize/${FILENAME}-full.png" "./fullsize/${FILENAME}.png"
convert ./fullsize/${FILENAME}.png \
    -gravity North -background White  -splice 0x40 \
    -fill Black -draw 'line 0,40 1024,40' \
    -pointsize 18 -annotate +0+2 "$FILENAME" \
    -gravity Center -append ./fullsize/${FILENAME}.png
convert ./fullsize/${FILENAME}.png -resize 600x ./fullsize/${FILENAME}.png
echo ""

