# ubuntu

## 1. Fix arrow key terminal

```
sudo chsh -s /bin/bash <username>
```

## 2. Error change host key

```
ssh-keygen -R <hostname>
```

## 3. Change hostname

```
hostname <NEW_NAME>
```

## 4. Push directory to another server

```
scp -r /path/to/local/dir user@remotehost:/path/to/remote/dir
```

## 5. Copy file

```
cp target_path destination_path
```

## 6. Check Server

```
# RAM
free -m

# Hard disk
df -h
```

## 7. Show app using port

```
# find port
netstat -tulpn | grep --color :3000

# show app
netstat -lp
```