#!/bin/bash
#export $(xargs < ../.env)
source ../../globals/colors.sh

print_heading() {
	HEAD=$1
	echo -e "\n${Red}[+] ################### $HEAD ###################${Color_Off}\n"
}

 DOMAIN=$1

# Print Host output
print_heading "Quick Host Lookup"
host $DOMAIN
echo

# Print Dig output
print_heading "Dig A Lookup"
dig $DOMAIN -t A +short
echo

# Print Dig output
print_heading "Dig NS Lookup"
dig $DOMAIN -t ns +short
echo

# Print Dig output
print_heading "Dig MX Lookup"
dig $DOMAIN -t MX +short
echo

# WHOIS
print_heading "Exporting WHOIS to file"
whois $DOMAIN > ../output/whois.txt
echo

# Save Shodan domain details
print_heading "Exporting SHODAN domain search results to file"
shodan domain $DOMAIN > ../output/shodan_domain.txt
echo


# Get Certs from Censys
print_heading "Censys - Certs exported"
censys --censys_api_id $CENSYS_API_ID --censys_api_secret $CENSYS_API_SECRET --query_type certs $DOMAIN > ../output/censys_certs.json
cat ../output/censys_certs.json | jq '.[0]["parsed.serial_number"]'
