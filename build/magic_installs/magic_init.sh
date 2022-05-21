#!/usr/bin/env bash

echo "================ Entering magic_init.sh ================"

# Must create this if it doesn't exist.  The default jupyter notebooks password is 'jupyter'
if [ ! -d "/home/${DEFAULT_USER}/.jupyter" ] || [ "$FRESH_START" == "yes" ]
then
  com="mkdir -p /home/${DEFAULT_USER}/.jupyter"
  echo "$com"
  eval "$com"
  com="cp /jupyter_notebook_config.json /home/${DEFAULT_USER}/.jupyter/jupyter_notebook_config.json"
  echo "$com"
  eval "$com"
  com="chmod -R 777 /home/${DEFAULT_USER}"
  echo "$com"
  eval "$com"
else
    echo "Running as a resumed session."
fi

# Shiny server examples setup
if [ ! -d "/home/${DEFAULT_USER}/shiny-server" ]
then
    mv -f /srv/shiny-server /home/${DEFAULT_USER}/.
else
    rm -rf /srv/shiny-server
fi
com="ln -s /home/${DEFAULT_USER}/shiny-server /srv/shiny-server"
echo "$com"
eval "$com"
com="chmod -R 777 /srv"
echo "$com"
eval "$com"

com="cp -rf /00_runcom /home/${DEFAULT_USER}/shiny-server/."
echo "$com"
eval "$com"

com="cp /dot_files/.bashrc /dot_files/.bash_logout /dot_files/.profile /home/${DEFAULT_USER}/."
echo "$com"
eval "$com"

com="chmod -R 777 /home/${DEFAULT_USER}"
echo "$com"
eval "$com"

com="cd ${MAGIC_FOLDER}"
echo "$com"
eval "$com"

com="su $DEFAULT_USER -c '/opt/venv/reticulate/bin/jupyter notebook --no-browser --ip=0.0.0.0 --port=8888 --allow-root &'"
echo "$com"
eval "$com"

echo "================ Finished magic_init.sh ================"
#nohup /init > /home/${DEFAULT_USER}/nohup.log &
/init
