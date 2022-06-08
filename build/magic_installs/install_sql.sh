#!/bin/bash

set -e
# ===========================
# Get the Powerhouse editor tools:
DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get upgrade -y
# ===========================
# Change the password for 'root' to "root"
echo "root:root" | chpasswd

echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
apt-get install -y mysql-server

# WORKS UP TO HERE
cp /magic_installs/my.cnf /etc/mysql/my.cnf

mysql_secure_installation

mysql -u root -p -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

# ===========================
