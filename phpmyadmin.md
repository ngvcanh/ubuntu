## 1. Install phpMyAdmin

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

## 2. Config MySQL

```
sudo mysql
```

Or

```
mysql -u root -p
```

Check which authentication method each of your MySQL user accounts use

```sql
SELECT user,authentication_string,plugin,host FROM mysql.user;
```


Change `password` to a strong password

```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```

Run FLUSH PRIVILEGES which tells the server to reload the grant tables and put new changes into effect

```sql
 FLUSH PRIVILEGES;
```

## 3. Fix error 404 for phpMyAdmin

Run command

```
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
```

OR, open `/etc/apache2/apache2.conf` and add end of file:

```
IncludeOptional /etc/phpmyadmin/apache.conf
```

Close file and restart apache2

## 4. Fix error count() parameter

Open lib

```
sudo vi /usr/share/phpmyadmin/libraries/sql.lib.php
```

Goto line 613

```
:613
```

Change content of line 613 as following:

```php
|| (count($analyzed_sql_results['select_expr']) == 1
```