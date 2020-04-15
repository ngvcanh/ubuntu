# Install TomCat on Ubuntu

## 1. Install JDK

```
apt update
apt install default-jdk
# If server required JDK8
apt install openjdk-8-jdk
```

## 2. Create TomCat user

```
groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
```

## 3. Install TomCat

```
cd /tmp

curl -O http://mirror.downloadvn.com/apache/tomcat/tomcat-10/v10.0.0-M4/bin/apache-tomcat-10.0.0-M4.tar.gz


mkdir /opt/tomcat
tar -xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1
```

## 4. Permissions TomCat

```
cd /opt/tomcat
chgrp -R tomcat /opt/tomcat

chmod -R g+r conf
chmod g+x conf
chown -R tomcat webapps/ work/ temp/ logs/
```

## 5. Create TomCat Service

```
update-java-alternatives -l

# Output
java-1.11.0-openjdk-amd64      1111       /usr/lib/jvm/java-1.11.0-openjdk-amd64
java-1.8.0-openjdk-amd64       1081       /usr/lib/jvm/java-1.8.0-openjdk-amd64
```

Create Service

```
vi /etc/systemd/system/tomcat.service
```

Add content

```
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target
[Service]
Type=forking
Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always
[Install]
WantedBy=multi-user.target
```

Reload deamon

```
systemctl daemon-reload
```

Start TomCat

```
systemctl start tomcat
```

Check status

```
systemctl status tomcat
```

Enable firewall

```
ufw allow 8080
ufw reload
```

Visit IP Server to check

```
http://IP_SERVER:8080
```

## 6. Config web TomCat

No user have been configured for Tomcat default to access and manager TomCat. So, config user:

```
vi /opt/tomcat/conf/tomcat-users.xml
```

Add content

```
<tomcat-users ...>
    <user username="admin" password="password" roles="manager-gui,admin-gui"/>
</tomcat-users>
```

For default, Manager App and Host manager App will limit IP access. So, if you want to remote access, edit XML

```
vi /opt/tomcat/webapps/manager/META-INF/context.xml
vi /opt/tomcat/webapps/host-manager/META-INF/context.xml
```

Comment limit IP tag:

```
<Context antiResourceLocking="false" privileged="true" >
  <!--<Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
</Context>
```

Reload TomCat

```
systemctl restart tomcat
```