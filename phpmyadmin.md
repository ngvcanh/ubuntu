## Install phpMyAdmin

```
    sudo apt update
    sudo apt install phpmyadmin php-mbstring php-gettext
```

Select web service to continue

When install success, run command:

```
    sudo phpenmod mbstring
```

Afterwards, restart Apache for your changes to be recognized:

```
    sudo systemctl restart apache2
```

## Config MySQL

```
    sudo mysql
```

Or

```
    mysql -u root -p
```

Check which authentication method each of your MySQL user accounts use

```mysql
    SELECT user,authentication_string,plugin,host FROM mysql.user;
```


Change `password` to a strong password

```mysql
    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```

Run FLUSH PRIVILEGES which tells the server to reload the grant tables and put new changes into effect

```mysql
    FLUSH PRIVILEGES;
```

## Fix error 404 for phpMyAdmin

Run command

```
    sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
```