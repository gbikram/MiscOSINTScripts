#!/bin/bash

# Download database
curl -X GET 'https://apt.thaicert.or.th/cgi-bin/getcard.cgi?g=all&o=j' > thaicert_db.json

# Show data for actors where observed sectors contains Government.
cat thaicert.json | jq '.values[] | select(has("tools") == true) | select(has("observed-countries") == true) | select(has("motivation") == true) | select(has("observed-sectors") == true) | select (."observed-sectors"[] | contains ("Government")) |"\(.actor);\(.tools[]);\(."observed-countries"[]);\(.motivation[])"'

# Show data for actors where actor country is Iran and target sector is related to Technology.
cat thaicert.json | jq '.values[] | select(has("tools") == true) | select(has("observed-countries") == true) | select(has("motivation") == true) | select(has("observed-sectors") == true) | select (.country[] | contains ("Iran")) | select (."observed-sectors"[] | contains ("Technology"))  | "\(.actor);\(.tools[]);\(."observed-countries"[]);\(.motivation[])"' > csv_output.csv

# Show report URLs for all actors from China 
cat thaicert.json | jq '.values[] | select(has("tools") == true) | select(has("observed-countries") == true) | select(has("motivation") == true) | select(has("observed-sectors") == true) | select(has("information") == true) | select (.country[] | contains ("China")) | "\(.information[])"'

# Show PDF reports URLs for all actors from China 
cat thaicert.json | jq '.values[] | select(has("tools") == true) | select(has("observed-countries") == true) | select(has("motivation") == true) | select(has("observed-sectors") == true) | select(has("information") == true) | select (.country[] | contains ("China")) | "\(.information[])"' | grep -e 'https://.*\.pdf'
