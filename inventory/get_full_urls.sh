#!/bin/bash

if [ -z $1 ]
then
  echo ""
  echo "Please provide a URL to a spreadsheet"
  echo ""
  exit 1
fi

COUNT=0

# get URLs and produce thumbnails

URL=$1

wget –no-check-certificate -q -O - $URL | cut -d',' -f1-5 | tail -n +2 | while IFS=, read Subdomain Number Name URL Printed Action Notes
  do
    # read col1 col2 < <(echo $line)
    if [ -n "$Subdomain" ] && [ -n "$Number" ] && [ -n "$Name" ] && [ -n "$URL" ]
    then
      let COUNT=COUNT+1
      RENAME="${Name//[^\x00-\x7F]/_}" # for non ascii stuff
      RENAME="${RENAME// /_}" # spaces suck
      RENAME="${RENAME//./_}" # also periods
      RENAME="${RENAME//,/_}" # also commas
      RENAME=`echo $RENAME | cut -c 1-30` # truncate the name
      FILENAME="_full-${Subdomain}-${Number}_${RENAME}"
      echo "($COUNT) Creating: ${FILENAME}"
      webkit2png --ignore-ssl-check -F --delay=1 --width=1024 ${URL} -o "./fullsize/${FILENAME}"
      mv "./fullsize/${FILENAME}-full.png" "./fullsize/${FILENAME}.png"
      convert ./fullsize/${FILENAME}.png \
          -gravity North -background White  -splice 0x40 \
          -fill Black -draw 'line 0,40 1024,40' \
          -pointsize 18 -annotate +0+2 "$FILENAME" \
          -gravity Center -append ./fullsize/${FILENAME}.png
      convert ./fullsize/${FILENAME}.png -resize 600x ./fullsize/${FILENAME}.png
      echo ""
    fi
  done

# assemble final PDF
SUFFIX=$(date +%s)
convert 'images/_full-*.png' full_page_index_${SUFFIX}.pdf

