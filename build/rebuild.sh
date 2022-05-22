#!/usr/bin/env bash

docker container stop data_science_lab
docker container prune -f
bash goodsy_dockerbuild_icing.sh
