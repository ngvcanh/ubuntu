# MongoDB 4.0 via PPD

Follow : `https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/`

## 1. Install MongoDB

Import the public key used by the package management system

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
```

Create a empty content list file for MongoDB: `/etc/apt/sources.list.d/mongodb-org-4.0.list`

Create the **/etc/apt/sources.list.d/mongodb-org-4.0.list** file

```
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
```

Reload local package database

```
sudo apt-get update
```

Install the MongoDB packages.

```
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
```

## 2. Config authentication MongoDB

Open Mongo shell context

```
mongo
```
Use admin database

```
use admin
```

Create User for authentication mongodb
```js
db.createUser(
    {
        user: "useradmin",
        pwd: "password_for_useradmin",
        roles: [ { role: "root", db: "admin" } ]
    }
)
```

Logout mongo shell

```
exit;
```

Enable authentication in mongod configuration file

```
sudo vi /etc/mongod.conf
```

search for the following lines:

```
security:
    authorization: "disabled"
```

Change "disable" for "enabled", save the file and restart mongod

```
sudo systemctl restart mongod
```

## 3. Install PHP MongoDB Driver (PHP 7.2)

Install `phpize`

```
sudo apt install php7.2-dev
```

Install Driver

```
sudo pecl install mongodb
```

Create mod init file

```
sudo vi /etc/php/7.2/mods-available/mongodb.ini
```

Add content

```ini
extension=mongodb.so
```

Create symbolink

```
sudo bash
sudo echo "extension=mongodb.so" >> /etc/php/7.2/apache2/php.ini
```

Restart apache

```
sudo systemctl restart apache2
```