#!/usr/bin/env bash

local_ip=$(ifconfig en0 | grep "inet " | cut -d " " -f 2)

SCRIPT_PATH="${BASH_SOURCE}"
while [ -L "${SCRIPT_PATH}" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

echo "SCRIPT_PATH=${SCRIPT_PATH}"
echo "SCRIPT_DIR=${SCRIPT_DIR}"

local_magic_home="${SCRIPT_DIR}/magic_home"
# check if the magic directory exists:
# if it doesn't exist: this is a first-time run and the dot-files the container created will need to be retained
# if it does exist, the user probably wants to continue from a previous session with the dotfiles etc from previously
fresh_start="yes"
if [ -d "$local_magic_home" ]
then
    fresh_start="no"
    echo "Directory $local_magic_home exists - continuing from previous session."
else
    fresh_start="yes"
    echo "Directory $local_magic_home does not exist - treating as fresh start."
    mkdir "$local_magic_home"
fi

docker_magic_home="/Volumes/Abyss/magic_home"
volume_string="${local_magic_home}:${docker_magic_home}"

docker run -it --rm -p 8787:8787 -p 3838:3838 -p 8888:8888 \
              --name data_science_lab \
              -e "${local_ip}:0" \
              -e MAGIC_FOLDER="${magic_home}" \
              -e FRESH_START="$fresh_start" \
              -v ${volume_string} \
              -e DISABLE_AUTH=true \
              goodsy/data_science_lab:ubuntu20_r420_202205_win bash
