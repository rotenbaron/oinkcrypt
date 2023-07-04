#!/bin/bash

DOMAIN=$1
APIKEY=$2
AUTH_OUTPUT=$3

echo "Deleting DNS record..."
echo "CERTBOT_AUTH_OUTPUT: $AUTH_OUTPUT"
response=$(curl -s -X POST -d "{\"secretapikey\": \"$SECRET\", \"apikey\": \"$APIKEY\"}" "https://porkbun.com/api/json/v3/dns/delete/$DOMAIN/$AUTH_OUTPUT")
echo "Response: $response"