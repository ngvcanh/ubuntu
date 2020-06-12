#!/bin/bash

###############################################################################
#     INSTALL WEB SERVICE ON UBUNTU                                           #
#                                                                             #
# Bourne-Again SHell                                                          #
# Target OS : ubuntu-18.04                                                    #
# Service   : apache2                                                         #
#           , php-5.6                                                         #
#           , mysql                                                           #
#           , nodejs                                                          #
#           , firewall                                                        #
#           , let's encrypt                                                   #
# Author    : Ken Nguyen                                                      #
# Privilege : root                                                            #
#                                                                             #
###############################################################################

# Before execute this file, you must chmod +x permission for it.
# chmod +x install-service-ubuntu.sh

# Delete this package expect when script is done
# 0 - No; 
# 1 - Yes.
PURGE_EXPECT_WHEN_DONE=0

# Current Password for MySQL when install
# If MySQL is new install, current password is null
CURRENT_MYSQL_PASSWORD=''

# New Password for MySQL when install secure
NEW_MYSQL_PASSWORD=''

# NodeJS Version
NODEJS_VERSION='14.x'

# Swap memory
SWAP_SIZE=2048

# Color
C_RESET='\033[0m'
C_GREEN='\033[0;32m'
C_RED='\033[0;31m'
C_YELLOW='\033[0;33m'

# Function show text color green
function text_green{
  echo "$C_GREEN \n $1 $C_RESET"
}

# Function show text color red
function text_red{
  echo "$C_RED \n $1 $C_RESET"
}

# Function show text color red
function text_yellow{
  echo "$C_YELLOW \n $1 $C_RESET"
}

# Check the bash shell script is being run by root
if [[ $EUID -ne 0 ]]; then
  text_red "This script must be run as root" 1>&2
  exit 1
fi

# Check is expect package installed
#if [ $(dpkg-query -W -f='${Status}' expect 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
#  text_red "Can't find expect. Trying install it..."
#  aptitude -y install expect
#fi

##########################################
##  Update & Upgrade server
##########################################
text_green "Update server..."
apt update && apt upgrade -y

##########################################
##  Install and start Apache2
##########################################

# Install apache2
text_green "Install Apache2..."
apt-get install apache2 -y

# Start apache2
text_green "Start Apache2..."
systemctl start apache2

# Enable apache2, when server crash and/or reboot, apache2 will auto start
text_green "Enable Apache2..."
systemctl enable apache2

##########################################
## Install php-5.6
##########################################

# Currently, PHP support version 7.x, install php with 7.x version
# We need add repository php 5.6 for apt-get
text_green "Add repository PHP 5.6..."
add-apt-repository ppa:ondrej/php

# Update apt-get to add php5.6
text_green "Update repo..."
apt-get update

# Install php5.6
text_green "Install PHP 5.6..."
apt-get install -y php5.6

# Enable mod php5.6 for apache2
text_green "Enable mod PHP 5.6..."
a2enmod php5.6

# Install module for PHP 5.6
text_green "Install module PHP 5.6..."
apt install -y php5.6-common php5.6-bcmath php5.6-curl php5.6-fpm php5.6-gd php5.6-imap php5.6-intl php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-opcache php5.6-xml php5.6-xsl php5.6-zip

# Restart apache2
text_green "Restart Apache..."
systemctl restart apache2

##########################################
## Install MySQL
##########################################

# Install MySQL Server
text_green "Install MySQL Server..."
apt install mysql-server -y

# Start MySQL
text_green "Start MySQL..."
systemctl start mysql

# Enable MySQL, when server crash and/or reboot, MySQL will auto start
text_green "Enable MySQL..."
systemctl enable mysql

# Install secure mysql
text_green "Install secure MySQL..."
SECURE_MYSQL=$(expect -c "
  set timeout 3
  spawn mysql_secure_installation
  expect \"Enter current password for root (enter for none):\"
  send \"$CURRENT_MYSQL_PASSWORD\r\"
  expect \"root password?\"
  send \"y\r\"
  expect \"New password:\"
  send \"$NEW_MYSQL_PASSWORD\r\"
  expect \"Re-enter new password:\"
  send \"$NEW_MYSQL_PASSWORD\r\"
  expect \"Remove anonymous users?\"
  send \"y\r\"
  expect \"Disallow root login remotely?\"
  send \"y\r\"
  expect \"Remove test database and access to it?\"
  send \"y\r\"
  expect \"Reload privilege tables now?\"
  send \"y\r\"
  expect eof
")

# Execution mysql_secure_installation
echo "${SECURE_MYSQL}"

##########################################
## Install Firewall
##########################################

# Install firewall
text_green "Install Firewall..."
apt install ufw -y

# Enable firewall
text_green "Enable Firewall..."
echo "y" | ufw enable

# Allow access ssh
text_green "Firewall allow access SSH..."
ufw allow ssh

# Allow access web service
text_green "Firewall allow access HTTP and HTTPS..."
ufw allow "Apache Full"

# Reload Firewall
text_green "Reload Firewall..."
ufw reload

##########################################
## SWAP Memory
##########################################

# Create swap
text_green "Create SWAP..."
dd if=/dev/zero of=/swapfile bs=$SWAP_SIZE count="${SWAP_SIZE}k"

# Create partition
text_green "Create Partition SWAP..."
mkswap /swapfile

# Enable swap
text_green "Enable SWAP..."
swapon /swapfile
echo /swapfile none swap defaults 0 0 >> /etc/fstab

##########################################
## Install NodeJS
##########################################

# Get package NodeJS with CURL
text_green "Download NodeJS..."
curl -sL https://deb.nodesource.com/setup_$NODEJS_VERSION | sudo -E bash -

# Install NodeJS
text_green "Install NodeJS..."
apt-get install -y nodejs

# Install Yarn
text_green "Get pagekage Yarn..."
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

text_green "Check pagekage Yarn..."
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

text_green "Install Yarn..."
apt-get update && apt-get install yarn -y

# Install nodemon
text_green "Install nodemon..."
npm install -g nodemon

# Install PM2
text_green "Install pm2..."
npm install -g pm2
pm2 startup
pm2 save

##########################################
## Install certbot
##########################################

# Add repository certbot
text_green "Add repository certbot..."
add-apt-repository ppa:certbot/certbot -y

# Install cerbot
text_green "Install certbot..."
apt install certbot python-certbot-apache -y

##################################################
## Delete package

if [ "${PURGE_EXPECT_WHEN_DONE}" -eq 1 ]; then
    # Uninstalling expect package
    aptitude -y purge expect
fi
exit 0