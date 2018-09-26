# RockMongo PHP7

Follow: `https://medium.com/@RichieOmoka/running-rockmongo-on-php7-b4b39a180840`

## 1. Install RockMongo

Clone rockmongo for PHP 7 from github

```
sudo git clone https://github.com/krutpong/rockmongo-php7
```

Create folder contain rockmongo

```
sudo mkdir -p /var/www/html/rockmongo
```

Move project Rockmongo to new folder

```
sudo mv rockmongo-php7/* /var/www/html/rockmongo
```

Run test project

```
http://your_domain_or_ip/rockmongo
```

Login with user `admin` and password `admin`

## 2. Fix error when mongodb enable secure authenticate

Open Model

```
sudo vi /var/www/html/rockmongo/app/models/MDb.php
```

Go to line 35

```
:35
```

Remove `true`. Save file: `ESC` and `:x`. 

Change authenticate information

```
sudo vi sudo vi /var/www/html/rockmongo/config.php
```

Change "MONGO_USER" and "MONGO_PASSWORD". Recomment lines. Reload page.