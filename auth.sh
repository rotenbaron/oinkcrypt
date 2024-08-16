# auth.sh
#!/bin/bash

echo "Creating DNS record..."
echo "CERTBOT_VALIDATION: $CERTBOT_VALIDATION"
response=$(curl -s -X POST -d "{\"secretapikey\": \"$SECRET\", \"apikey\": \"$APIKEY\", \"name\": \"_acme-challenge\", \"type\": \"TXT\", \"content\": \"$CERTBOT_VALIDATION\", \"ttl\": \"600\"}" "https://porkbun.com/api/json/v3/dns/create/$DOMAIN")
echo "Response: $response"
id=$(echo "$response" | jq -r '.id')
echo "ID: $id"

# Append the ID to the temporary file
echo "$id" >> certbot_auth_output_$DOMAIN.txt

echo "Waiting for DNS propagation..."
sleep 30
