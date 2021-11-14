#!/bin/bash

FILES=${1:-"/mnt/d/downloads/pepperplate_recipes/*.txt"}
for f in $FILES
do
 echo "Processing $f"
#  URL=$(sed -nre '/^Image:/ {s/^Image: *(.*)$/\1/;s/\r$//; p}' $f)
#  echo "$URL"
#  if [ $URL ]; then
#   wget -O file "$URL" 
#   cat file | uuencode -m test | sed -r -e "1,1 d ; /===/,/===/ d; s/^/  /" > ./photo.pic
#  elif [ -a ./photo.pic ]; then
#   rm ./photo.pic
#  fi
 sed -r -f ./yamlize.sed "$f" > "$f.yml"
done