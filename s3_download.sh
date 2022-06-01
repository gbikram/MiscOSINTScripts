#!/bin/bash

curl -X GET $1 > s3.xml

cat s3.xml | grep -E '<Key>.*</Key>' | sed 's/<Key>//g' | sed 's/<\/Key>//g' > keys_parsed.txt

while read -r line
	do
		wget https://images.central.arubanetworks.com/$line
	done < keys_parsed.txt


