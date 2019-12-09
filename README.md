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