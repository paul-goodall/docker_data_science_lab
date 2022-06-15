
apt-get update
apt-get install -y libiodbc2
apt-get install -y unixodbc odbcinst

wget https://sfc-repo.snowflakecomputing.com/odbc/linux/2.25.2/snowflake-odbc-2.25.2.x86_64.deb
apt install ./snowflake-odbc-2.25.2.x86_64.deb
echo "ANSIENCODING=UTF-8" >> /usr/lib/snowflake/odbc/lib/simba.snowflake.ini

