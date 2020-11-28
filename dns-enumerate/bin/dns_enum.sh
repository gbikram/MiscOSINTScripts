#!/bin/bash 
export $(xargs < ../.env)
source colors.sh

DOMAIN=$1

# Print Host output
echo -e "${Red}################ Quick Host Lookup${Color_Off}\n"
host $DOMAIN
echo

# Print Dig output
echo -e "${Red}############### Dig A Lookup${Color_Off}"
dig $DOMAIN -t A +short
echo

# Print Dig output
echo -e "${Red}############### Dig NS Lookup${Color_Off}"
dig $DOMAIN -t ns +short
echo

# Print Dig output
echo -e "${Red}############### Dig MX Lookup${Color_Off}"
dig $DOMAIN -t MX +short
echo

# WHOIS
echo -e "${Red}############## Exporting WHOIS to file${Color_Off}"
whois $DOMAIN > ../output/whois.txt
echo

# Save Shodan domain details
echo -e "${Red}############# Exporting SHODAN domain search results to file${Color_Off}"
shodan domain $DOMAIN > ../output/shodan_domain.txt
echo


# Get Certs from Censys
echo -e "${Red}############## Censys - Certs exported${Color_Off}"
censys --censys_api_id $CENSYS_API_ID --censys_api_secret $CENSYS_API_SECRET --query_type certs $DOMAIN > ../output/censys_certs.json
cat ../output/censys_certs.json | jq '.[0]["parsed.serial_number"]'

