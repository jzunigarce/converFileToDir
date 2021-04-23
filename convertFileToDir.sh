#!/bin/bash

#Check if user give a one arg
if [ $# -eq 0 ]; then
		echo "No arguments supplied"
		exit 1
fi

directory=$1

if [ -z $2 ]; then
	ext='*'
else
	ext="$2"
fi

#Check if arg is a directory
if [ ! -d "$directory" ]; then
	echo "This directory does not exist!"
	exit 1
fi

OIFS="$IFS"
IFS=$'\n'
for file in `find $directory -type f -name "*.$ext"`  
do
	filename="$(basename "$file" | sed 's/\(.*\)\..*/\1/')"
	mkdir -p "$directory"/"$filename"
	echo "=============== ✔️  Created directory $filename ==============="
	cp $file "$directory"/"$filename"
	echo "📋 Copy $file to $filename directory"
done
IFS="$OIFS"
