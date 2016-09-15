#!/bin/bash

# IFS=','
# wget –no-check-certificate -q -O - 'https://docs.google.com/spreadsheets/d/1gcAHUEZCFQ83t5LYpzTR6KbDhf6NYLfUZ7hyz_bhT1c/pub?gid=0&single=true&output=csv' | cut -d',' -f1-5 | read -a
# while read -a line; do
#     for i in "${!line[@]}"; do
#         echo "${headers[i]}: ${line[i]}"
#     done
# done


# INPUT_FILE='unix_file.csv'

# IFS=','

# while read OS HS
# do

# echo "Operating system - $OS"
# echo "Hosting server type - $HS"

# done < $INPUT_FILE

COUNT=0

# get URLs and produce thumbnails

wget –no-check-certificate -q -O - 'https://docs.google.com/spreadsheets/d/1gcAHUEZCFQ83t5LYpzTR6KbDhf6NYLfUZ7hyz_bhT1c/pub?gid=0&single=true&output=csv' | cut -d',' -f1-5 | tail -n +2 | while IFS=, read Subdomain Number Name URL Printed Action Notes
  do
    # read col1 col2 < <(echo $line)
    if [ -n "$Subdomain" ] && [ -n "$Number" ] && [ -n "$Name" ] && [ -n "$URL" ]
    then
      let COUNT=COUNT+1
      RENAME="${Name// /_}"
      FILENAME="${Subdomain}-${Number}_${RENAME}"
      FILENAME="${FILENAME//(/_}"
      FILENAME="${FILENAME//)/_}"
      echo "($COUNT) Creating: ${FILENAME}"
      webkit2png --ignore-ssl-check -C --delay=5 --clipwidth=300 --clipheight=300 ${URL} -o ./images/${FILENAME}
      mv ./images/${FILENAME}-clipped.png ./images/${FILENAME}.png
      convert ./images/${FILENAME}.png \
          -gravity South   -background White  -splice 0x40 \
          -fill Black -draw 'line 0,600 600,600' \
          -pointsize 18 -annotate +0+2 "$FILENAME" \
          -gravity Center -append ./images/${FILENAME}.png
      echo ""
    fi
  done

# assemble final PDF
SUFFIX=$(date +%s)
convert 'images/*.png' page_index_${SUFFIX}.pdf

