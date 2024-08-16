# renew.sh
#!/bin/bash

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
  --email rotenbaron@gmail.com \
  --manual \
  --agree-tos \
  --server https://acme-v02.api.letsencrypt.org/directory \
  --manual-auth-hook "$(dirname "$0")/auth.sh" \
  --manual-cleanup-hook "$(dirname "$0")/cleanup.sh $DOMAIN $APIKEY" | tee -a $DOMAIN.log

# Clean up the temporary file
rm -f certbot_auth_output_$DOMAIN.txt

# Display the result
echo "Certificate obtained and DNS records deleted."

# Reload Nginx
# uncomment if needed
#systemctl reload nginx
#echo "Nginx reloaded."