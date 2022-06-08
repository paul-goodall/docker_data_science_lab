#!/bin/bash

set -e
# ===========================
# Get the Powerhouse editor tools:
DEBIAN_FRONTEND=noninteractive
apt update && apt upgrade -y
# ===========================
# Change the password for 'root' to "root"
echo "root:root" | chpasswd

apt install -y postgresql postgresql-contrib
service postgresql start
sudo -u postgres psql --dbname=postgres -c "CREATE ROLE root WITH LOGIN SUPERUSER PASSWORD 'root';"
sudo -u postgres psql --dbname=postgres -c "CREATE ROLE rstudio WITH LOGIN SUPERUSER PASSWORD 'password';"
sudo -u postgres psql --dbname=postgres -c "ALTER ROLE root CREATEDB;"
sudo -u postgres psql --dbname=postgres -c "ALTER ROLE rstudio CREATEDB;"
sudo -u postgres psql --dbname=postgres -c "CREATE DATABASE rstudio;"


# ===========================
