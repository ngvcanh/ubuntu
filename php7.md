# Install PHP 7.2

## 1. Update Server

```
sudo apt-get update && apt-get upgrade
```

## 2. Install PHP

```
sudo apt-get install php
```

## 3. Install module

```
sudo apt-get install php-pear php7.2-dev php7.2-zip php7.2-curl php7.2-gd php7.2-mysql libmcrypt-dev php7.2-xml libapache2-mod-php7.2
```

Install mcrypt

```
sudo pecl install mcrypt-1.0.1
```

Create ini file

```
sudo vi /etc/php/7.2/mods-available/mcrypt.ini
```

Insert content

```
extension=mcrypt.so
```

Create Symbolic link

```
sudo ln -s /etc/php/7.2/mods-available/mcrypt.ini /etc/php/7.2/apache2/conf.d/20-mcrypt.ini
sudo ln -s /etc/php/7.2/mods-available/mcrypt.ini /etc/php/7.2/cli/conf.d/20-mcrypt.ini
```
# Install PHP 7.3

## 1. Install PHP

```
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
apt update
apt install php7.3 php7.3-cli php7.3-common
```

## 2. Install specific PHP 7.3 extensions

```
apt-cache search php7.3
```

Install extensions show.

Or, install extension:

```
apt install php-http php-geoip php-imagick php-mailparse php-memcache php-memcached php-mongodb php-uploadprogress php-uuid php-yaml libapache2-mod-php7.3 libphp7.3-embed php-lua php-phalcon php-xdebug php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-common php7.3-curl php7.3-dba php7.3-dev php7.3-fpm php7.3-gd php7.3-imap php7.3-interbase php7.3-intl php7.3-json php7.3-mbstring php7.3-mysql php7.3-odbc php7.3-opcache php7.3-pgsql php7.3-recode php7.3-soap php7.3-sqlite3 php7.3-tidy php7.3-xml php7.3-xsl php7.3-zip
```

# Change version PHP

```
# PHP 7.0
update-alternatives --set php /usr/bin/php7.0
# PHP 7.2
update-alternatives --set php /usr/bin/php7.2
# PHP 7.3
update-alternatives --set php /usr/bin/php7.3
```

Before we can configure Apache to use PHP 7.3, we need to disable the old version of PHP 7.0 by typing:

```
a2dismod php7.0
a2enmod php7.3
systemctl restart apache2
```