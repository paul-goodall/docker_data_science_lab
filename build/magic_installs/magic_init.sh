#!/usr/bin/env bash

echo "================ Entering magic_init.sh ================"


cp -rT /magic_installs/rstudio /home/${DEFAULT_USER}/.
cp -rf /magic_installs/rstudio/.bashrc /home/${DEFAULT_USER}/.
cp -rf /magic_installs/rstudio/.bash_logout /home/${DEFAULT_USER}/.
cp -rf /magic_installs/rstudio/.profile /home/${DEFAULT_USER}/.
cp -rf /magic_installs/rstudio/.jupyter /home/${DEFAULT_USER}/.

chmod -R 777 $DOCKER_MAGIC_DIR/

# Shiny server examples setup
rm -rf /srv/shiny-server
ln -s /home/${DEFAULT_USER}/shiny-apps /srv/shiny-server
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

service ssh restart

echo "================ Finished magic_init.sh ================"
#nohup /init > /home/${DEFAULT_USER}/nohup.log &
/init
