## Wildcard Certificate Renewal Script for Let's Encrypt Certbot and Porkbun API

This repository contains a Bash script that automates the process of obtaining a wildcard certificate using Let's Encrypt and managing DNS records through the Porkbun API. The script uses Certbot for certificate generation, manual authentication, and cleanup.

### Prerequisites

Before using this script, make sure you have the following:

- A domain registered with [Porkbun](https://porkbun.com/)
- A working installation of [Certbot](https://certbot.eff.org/) on your system
- [jq](https://stedolan.github.io/jq/) installed on your system. You can install it using your package manager (`sudo apt install jq` for Ubuntu/Debian).

### Usage

1. Clone the repository:

   ```shell
   git clone https://github.com/rotenbaron/oinkcrypt.git
   ```

2. Navigate to the repository directory:

   ```shell
   cd oinkcrypt
   ```

3. Make the scripts executable:

   ```shell
   chmod +x renew.sh auth.sh cleanup.sh
   ```

4. Generate Porkbun API key and Secret key by following the [Porkbun API documentation](https://porkbun.com/account/api). Make sure to enable API access for your domain in the domain settings.

5. Run the `renew.sh` script to generate the wildcard certificate:

   ```shell
   ./renew.sh DOMAIN APIKEY SECRET
   ```

   Replace `DOMAIN`, `APIKEY`, and `SECRET` with your actual values. The script will guide you through the process of creating a DNS TXT record for authentication. Follow the instructions and wait for DNS propagation (30 seconds by default).

6. Once the certificate is obtained and the DNS records are propagated, the cleanup script will automatically run to delete the DNS record. You don't need to run it manually.

7. The certificate and key files will be saved in the `/etc/letsencrypt/live/<your-domain>/` directory.

### Running as a Cron Job

To automate the certificate renewal process, you can set up a cron job to run the script periodically. Here's an example of a cron job entry that runs the script every month. Run cron editor (`sudo crontab -e` for Ubuntu/Debian) and paste following line:

```shell
0 0 1 * * /path/to/oinkcrypt/renew.sh DOMAIN APIKEY SECRET > /path/to/oinkcrypt/certbot.log
```

Make sure to update the paths according to your system setup.

### Troubleshooting

If you encounter any issues or errors during the certificate renewal process, refer to the Certbot and Porkbun documentation for troubleshooting steps. Additionally, check the log file `certbot.log` for detailed information about the script execution and any error messages.

### Contributing

Contributions to this repository are welcome. If you encounter any bugs or have suggestions for improvements, feel free to open an issue or submit a pull request.

### License

This script is licensed under the [MIT License](LICENSE). Feel free to modify and distribute it according to your needs.