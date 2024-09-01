#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

WORKINGDIR="$1"

if [ ! -d "$WORKINGDIR" ]; then
  echo "$WORKINGDIR is not a valid directory."
  exit 1
fi

for file in "$WORKINGDIR"/*; do
  if [ -f "$file" ]; then
    HASH=$(md5sum "$file" | awk '{ print $1 }')
    EXT="${file##*.}"

    NEWFILE="$WORKINGDIR/$HASH.${EXT}"

    mv "$file" "$NEWFILE"
    echo "$WORKINGDIR/$file -> $NEWFILE"
  fi
done
