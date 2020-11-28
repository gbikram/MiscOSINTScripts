#!/bin/bash

QUERY_TYPE=$1
DOMAIN=$2

if [ $QUERY_TYPE == 'search' ]
then
	curl https://urlscan.io/api/v1/search/?q=domain:$DOMAIN
fi
# curl -H "Content-Type: application/json" -H "API-KEY: f61d3e99-2c48-47f9-8211-47911ecb7fc8" $DOMAIN
