#!/usr/bin/env bash

echo "================ Entering magic_init.sh ================"


cp -rT /magic_installs/rstudio /home/${DEFAULT_USER}/.
cp -rf /magic_installs/rstudio/.bashrc /home/${DEFAULT_USER}/.
cp -rf /magic_installs/rstudio/.bash_logout /home/${DEFAULT_USER}/.
cp -rf /magic_installs/rstudio/.profile /home/${DEFAULT_USER}/.
cp -rf /magic_installs/rstudio/.jupyter /home/${DEFAULT_USER}/.

chmod -R 777 $DOCKER_MAGIC_DIR/

# Get the latest ddsl_content if it doesn't exist:
ddsl_dir="/Volumes/Abyss/rstudio/ddsl_content"
[ ! -d "$ddsl_dir" ] && git clone https://github.com/paul-goodall/ddsl_content.git $ddsl_dir
#

# Shiny server examples setup
rm -rf /srv/shiny-server/*
ln -s /home/${DEFAULT_USER}/ddsl_content/shiny-apps /srv/shiny-server/.
ln -s /home/${DEFAULT_USER}/my_work/my_shiny_apps /srv/shiny-server/.
chmod -R 777 /srv

chmod -R 777 /home/${DEFAULT_USER}

#/magic_installs/run_iperl.sh
cd ${MAGIC_FOLDER}
su $DEFAULT_USER -c '/opt/venv/reticulate/bin/jupyter notebook --no-browser --ip=0.0.0.0 --port=8888 --allow-root &'
#su $DEFAULT_USER -c '/magic_installs/run_iperl.sh &'

if [ -z ${USER_PASSWORD+x} ]
then
  echo "User password not changed."
else
  echo "Updating User password."
  echo "${DEFAULT_USER}:${USER_PASSWORD}" | chpasswd
fi

# Start ssh
service ssh restart

# deal with postgres:
postgres_data_dir_old="/var/lib/postgresql"
data_dir_new="/Volumes/Abyss/rstudio/system_data"
postgres_data_dir_new="${data_dir_new}/postgresql"
service postgresql stop
sleep 1
[ ! -d "$postgres_data_dir_new" ] && mv -f ${postgres_data_dir_old} ${data_dir_new}/.
rm -rf ${postgres_data_dir_old}
ln -s ${postgres_data_dir_new} ${postgres_data_dir_old}
service postgresql restart

echo "================ Finished magic_init.sh ================"
#nohup /init > /home/${DEFAULT_USER}/nohup.log &
/init
