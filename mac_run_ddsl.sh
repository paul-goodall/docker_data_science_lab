#!/usr/bin/env bash

# ===================================
user_password="password"
local_magic_home="rstudio"
# Leave local_magic_path blank to default to: CWD/local_magic_home
# else set it to a full path to override
local_magic_path=""
# ===================================

  local_ip=$(ifconfig en0 | grep "inet " | cut -d " " -f 2)
  socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

  SCRIPT_PATH="${BASH_SOURCE}"
  while [ -L "${SCRIPT_PATH}" ]; do
    SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
    SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
    [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
  done

  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

echo "SCRIPT_PATH=${SCRIPT_PATH}"
echo "SCRIPT_DIR=${SCRIPT_DIR}"

# If local_magic_path is blank "" then create it relative to this script path.
if [[ $local_magic_path == "" ]]; then
local_magic_path="${SCRIPT_DIR}/${local_magic_home}"
fi

# check if the magic directory exists:
# if it doesn't exist: this is a first-time run and the dot-files the container created will need to be retained
# if it does exist, the user probably wants to continue from a previous session with the dotfiles etc from previously
fresh_start="yes"
if [ -d "$local_magic_path" ]
then
    fresh_start="no"
    echo "Directory $local_magic_path exists - continuing from previous session."
else
    fresh_start="yes"
    echo "Directory $local_magic_path does not exist - treating as fresh start."
    mkdir "$local_magic_path"
fi

# docker_magic_home cannot be changed here - it needs to match DOCKER_MAGIC_DIR from the icing dockerfile.
docker_magic_home="/Volumes/Abyss/rstudio"
volume_string="${local_magic_path}:${docker_magic_home}"

echo "SETUP:
local_ip = [${local_ip}]
local_magic_path = [${local_magic_path}]
docker_magic_home = [${docker_magic_home}]
fresh_start = [${fresh_start}]
"

open -a XQuartz
xhost + $(hostname)
#DISPLAY=$(hostname):0
#DISPLAY="${local_ip}:0"
#-v /tmp/.X11-unix:/tmp/.X11-unix \

docker run -d -p 8787:8787 -p 3838:3838 -p 8888:8888 -p 2222:22 \
              --name data_science_lab \
              -e HOST_OS="mac" \
              -e USER_PASSWORD=$user_password \
              -e DISPLAY=$(hostname):0 \
              -e MAGIC_FOLDER="${docker_magic_home}" \
              -e FRESH_START="$fresh_start" \
              -v ${volume_string} \
              -e DISABLE_AUTH=true \
              goodsy/docker_data_science_lab:latest
