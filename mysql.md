# Install MySQL

## 1. Install MySQL

```
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql
sudo mysql_secure_installation
```

## 2. Access login MySQL remote

```
sudo mysql -u root -p
```

View permission user

```sql
SELECT user,authentication_string,plugin,host FROM mysql.user;
```

Output:

```
+------------------+-------------------------------------------+-----------------------+-----------+
| user             | authentication_string                     | plugin                | host      |
+------------------+-------------------------------------------+-----------------------+-----------+
| root             |                                           | auth_socket           | localhost |
| mysql.session    | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE | mysql_native_password | localhost |
| mysql.sys        | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE | mysql_native_password | localhost |
| debian-sys-maint | *6FD1597101D91A4CB7E4B1B7376ECE50493EA4C1 | mysql_native_password | localhost |
+------------------+-------------------------------------------+-----------------------+-----------+
```

Query alter user

```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'new_password';
```

Apply permission

```
FLUSH PRIVILEGES;
```

## 3. Delete function in mysql

Login to mysql

```
mysql -u root -p
```

Enter password of root user. After login, run SQL

```sql
DROP FUNCTION function_name
```