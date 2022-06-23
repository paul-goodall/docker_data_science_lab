
sudo apt-get update 
sudo apt-get install -y software-properties-common
sudo apt-get update 

curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-preview.list)"

sudo ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev

sudo apt-get install -y mssql-server

MSSQL_SA_PASSWORD="Ms_Sql_Pass_123"
MSSQL_PID='evaluation'

sudo MSSQL_SA_PASSWORD=$MSSQL_SA_PASSWORD \
     MSSQL_PID=$MSSQL_PID \
     /opt/mssql/bin/mssql-conf -n setup accept-eula
     
# Default user is 'SA'
# To change the password:
# sudo MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD} /opt/mssql/bin/mssql-conf set-sa-password

echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

echo 'export PATH="$PATH:/opt/mssql/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql/bin"' >> ~/.bashrc

source ~/.bashrc

# Run init-script with long timeout - and make it run in the background
/opt/mssql-tools/bin/sqlcmd -S localhost -l 60 -U rstudio -P ${MSSQL_SA_PASSWORD} -i init.sql &
# Start SQL server
/opt/mssql/bin/sqlservr &

