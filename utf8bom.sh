#!/bin/bash

if [ ! -f "$1" ]
then
  echo "File $1 not found"
  exit
fi

if (( $(file "$1" | grep -Ec " ASCII | UTF-8 ") == 0 ))
then
  echo "File encoding is not UTF-8 or ASCII"
  exit
fi

if (( $(file "$1" | grep -c " (with BOM) ") > 0 ))
then
  echo "File already has the Byte order mark (BOM)"
  exit
fi

printf '\xEF\xBB\xBF' > "bom.tmp"
cat "$1" >> "bom.tmp"
mv "bom.tmp" "$1"
