# Install Gitea

Source: https://computingforgeeks.com/how-to-install-gitea-git-service-on-ubuntu/

## 1. Create a git system user

```
adduser \
  --system \
  --shell /bin/bash \
  --gecos 'Git Version Control' \
  --group \
  --disabled-password \
  --home /home/git \
  git
```

Test user

```
# id git
     uid=112(git) gid=117(git) groups=117(git)
```

## 2. Install MariaDB database server

View here https://github.com/ngvcanh/ubuntu/blob/master/mysql.md

Create a database for Gitea.

```
# mysql -u root -p

> CREATE DATABASE gitea;
> GRANT ALL PRIVILEGES ON gitea.* TO 'gitea'@'localhost' IDENTIFIED BY "StrongPassword";
> FLUSH PRIVILEGES;
> QUIT;
```
## 3. Install and configure Gitea

```
# export VER=1.8.1
# wget https://github.com/go-gitea/gitea/releases/download/v${VER}/gitea-${VER}-linux-amd64
```

Move the downloaded binary file to the `/use/local/bin` directory

```
chmod +x gitea-${VER}-linux-amd64
mv gitea-${VER}-linux-amd64 /usr/local/bin/gitea
```

confirm version installed using.

```
# gitea --version
Gitea version 1.8.1 built with: bindata, sqlite
```

Create the required directory structure.

```
mkdir -p /etc/gitea /var/lib/gitea/{custom,data,indexers,public,log}
chown git:git /var/lib/gitea/{data,indexers,log}
chmod 750 /var/lib/gitea/{data,indexers,log}
chown root:git /etc/gitea
chmod 770 /etc/gitea
```

The web installer will need **write** permission configuration file under `/etc/gitea`

Create a systemd service unit

```
vi /etc/systemd/system/gitea.service
```

Configure the file to set User, Group and WorkDir.

```
[Unit]
Description=Gitea (Git with a cup of tea)
After=syslog.target
After=network.target
After=mysql.service

[Service]
# Modify these two values and uncomment them if you have
# repos with lots of files and get an HTTP error 500 because
# of that
###
#LimitMEMLOCK=infinity
#LimitNOFILE=65535
RestartSec=2s
Type=simple
User=git
Group=git
WorkingDirectory=/var/lib/gitea/
ExecStart=/usr/local/bin/gitea web -c /etc/gitea/app.ini
Restart=always
Environment=USER=git HOME=/home/git GITEA_WORK_DIR=/var/lib/gitea
# If you want to bind Gitea to a port below 1024 uncomment
# the two values below
###
#CapabilityBoundingSet=CAP_NET_BIND_SERVICE
#AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```

Reload systemd and restart service

```
systemctl daemon-reload
systemctl restart gitea
```

enable the service to start on boot

```
systemctl enable gitea
systemctl status gitea
```

Start the installation by visiting http://serverip:3000/install

Refer install Apache
https://github.com/ngvcanh/ubuntu/blob/master/apache.md

Refer create VirtualHost and config Proxy
https://github.com/ngvcanh/ubuntu/blob/master/VirtualHost.md