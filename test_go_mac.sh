#!/usr/bin/env bash

rm -rf magic_home
docker container stop data_science_lab
docker container prune -f
bash ./run_dsl.sh
clear
sleep 1
docker logs data_science_lab
