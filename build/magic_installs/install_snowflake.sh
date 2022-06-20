#!/bin/bash

set -e
# ===========================
# Get the Powerhouse editor tools:
DEBIAN_FRONTEND=noninteractive
apt update && apt upgrade -y
# ===========================

apt-get install -y libiodbc2
apt-get install -y unixodbc odbcinst

wget https://sfc-repo.snowflakecomputing.com/odbc/linux/2.25.2/snowflake-odbc-2.25.2.x86_64.deb
apt install ./snowflake-odbc-2.25.2.x86_64.deb
echo "ANSIENCODING=UTF-8" >> /usr/lib/snowflake/odbc/lib/simba.snowflake.ini
