# Swapfile on ubuntu

## 1. Check Swap

```
swapon -s
```

## 2. Check empty disk

```
df -h
```

## 3. Create Swap

```
dd if=/dev/zero of=/swapfile bs=1024 count=1024k
```

`count=1024k` is 1GB for swap

## 4. Create partition

```
mkswap /swapfile
```

## 5. Enable swap

```
swapon /swapfile
echo /swapfile none swap defaults 0 0 >> /etc/fstab
```

## 6. Secure swap

```
chown root:root /swapfile 
chmod 0600 /swapfile
```

## 7. Config Swappiness

Swappiness is the priority to use swap, when the remaining RAM is equal to the value of swappiness (in percentage), the swap will be used. Swappiness is in the range of 0 - 100

```
# check swappiness
cat /proc/sys/vm/swappiness

# Change
sysctl vm.swappiness=10
```

To ensure that this parameter stays the same every time you restart your VPS, you need to adjust the vm.swappiness parameter at the end of /etc/sysctl.conf file (if you don't have one, please add it manually)

```
vi /etc/sysctl.conf
```

```
vm.swappiness = 10
```

Restart VPS.