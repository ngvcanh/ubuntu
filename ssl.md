# Install SSL Let's Encrypt

Source: https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-18-04

## 1. Installing Certbot

Add the repository:

```
add-apt-repository ppa:certbot/certbot
```

Press `ENTER` to accept.

Install Certbot's Apache package with `apt`:

```
apt install python-certbot-apache
```

## 2. Set Up the SSL Certificate

```
ufw allow 'Apache Full'
ufw delete allow 'Apache'
certbot --apache -d example.com -d www.example.com
ufw reload
systemctl restart apache2
```

## 3. Verifying Certbot Auto-Renewal

```
certbot renew --dry-run
```