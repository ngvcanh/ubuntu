# User manager

## 1. Add new user

```
sudo adduser <username>
```

## 2. Add sudoer program

```
sudo usermod -aG sudo <username>
```

## 3. Add permission for user

Open visudo

```
visudo
```

Specification privilege

```
<username> ALL=(ALL:ALL) ALL
```

## 4. Disable root user remote login ssh

Open ssh config

```
sudo vi /etc/ssh/sshd_config
```

Find

```
PermitRootLogin yes
```

Modify the line as follows:

```
PermitRootLogin no
```

Save file and reload ssh

```
systemctl restart sshd
```