#!/bin/bash

type=$1
query=$2
urlhaus_endpoint="https://urlhaus-api.abuse.ch/v1/"

if [ $type == 'host' ]
then
	response=$(wget -O- --post-data="host=$query" $urlhaus_endpoint"host/")
	query_status=$(echo $response | jq '.["query_status"]')
	echo
	if [ $query_status == '"ok"' ]
	then
		echo "Entry Exists!"
	else
		echo "Not found!"
	fi
fi
