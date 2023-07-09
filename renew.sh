#!/bin/bash

# Author: Rotenbaron
# Website: https://redthread.studio
# Repository: https://github.com/rotenbaron/oinkcrypt

# Set the domain, API key, and secret API key as command-line arguments
export DOMAIN=$1
export APIKEY=$2
export SECRET=$3

# Generate the wildcard certificate using Certbot with manual authentication and cleanup hooks
certbot certonly \
  --renew-by-default \
  -d *.$DOMAIN \
  -d $DOMAIN \
  --preferred-challenges dns \
  --manual --manual-public-ip-logging-ok --agree-tos \
  --server https://acme-v02.api.letsencrypt.org/directory \
  --manual-auth-hook "$(dirname "$0")/auth.sh" \
  --manual-cleanup-hook "$(dirname "$0")/cleanup.sh $DOMAIN $APIKEY $CERTBOT_AUTH_OUTPUT" | tee -a $(dirname "$0")/certbot.log

# Display the result
echo "Certificate obtained and DNS records deleted."