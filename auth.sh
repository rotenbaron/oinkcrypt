#!/bin/bash

echo "Creating DNS record..."
echo "CERTBOT_VALIDATION: $CERTBOT_VALIDATION"

response=$(curl -s -X POST -d "{\"secretapikey\": \"$SECRET\", \"apikey\": \"$APIKEY\", \"name\": \"_acme-challenge\", \"type\": \"TXT\", \"content\": \"$CERTBOT_VALIDATION\", \"ttl\": \"600\"}" "https://porkbun.com/api/json/v3/dns/create/$DOMAIN")

echo "Response: $response"

id=$(echo "$response" | jq -r '.id')
echo "ID: $id"

export CERTBOT_AUTH_OUTPUT="$id"

echo "Waiting for DNS propagation..."
sleep 30