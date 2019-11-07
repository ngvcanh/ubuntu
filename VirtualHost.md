# Virtual Host

## 1. Create VirtualHost

Install Apache2 https://github.com/ngvcanh/ubuntu/blob/master/apache.md

Create folder include site and folder include logs.

```
mkdir -p /var/www/example.com/public_html
mkdir -p /var/www/example.com/logs
```

Set permission for current logged in user

```
chown -R $USER:$USER /var/www/example.com
```

Set chmod

```
chmod -R 755 /var/www/example.com
```

Go to folder site config

```
cd /etc/apache2/sites-available/
```

Create configuration file

```
cp 000-default.conf example.com.conf
```

Open to edit config

```
vi example.com.conf
```

Change edit with content inside `<VirtualHost *>...</VirtualHost>`

```
ServerName www.example.com
ServerAlias example.com
DocumentRoot /var/www/git.greenint.net/public_html
ErrorLog /var/www/example.com/logs/error.log
CustomLog /var/www/example.com/logs/access.log combined
```

Save and close file `Esc`, `:x`
Enable site

```
a2dissite 000-default.conf
a2ensite example.com.conf
```

Reload Apache

```
systemctl reload apache2
```

## 2. Config Proxy

Open config file site

```
vi /etc/apache2/sites-available/example.com.conf
```

Add end of tag `<VirtualHost *>`

```
ProxyRequests off
<Proxy *>
  Order allow,deny
  Allow from all
</Proxy>
ProxyPass / http://localhost:3000/
ProxyPassReverse / http://localhost:3000/
ProxyPreserveHost on
```

Save and close file
Enable mod proxy

```
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer
a2enmod lbmethod_byrequests
```

Reload Apache

```
systemctl reload apache2
```