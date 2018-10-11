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