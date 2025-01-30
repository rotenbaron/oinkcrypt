# cleanup.sh
#!/bin/bash

# Set the domain, API key, and authentication output ID as command-line arguments
DOMAIN=$1
APIKEY=$2

# Read all IDs from the temporary file
while read -r AUTH_OUTPUT; do
    echo "Deleting DNS record..."
    echo "CERTBOT_AUTH_OUTPUT: $AUTH_OUTPUT"
    response=$(curl -s -X POST -d "{\"secretapikey\": \"$SECRET\", \"apikey\": \"$APIKEY\"}" "https://api.porkbun.com/api/json/v3/dns/delete/$DOMAIN/$AUTH_OUTPUT")
    echo "Response: $response"
done < certbot_auth_output_$DOMAIN.txt