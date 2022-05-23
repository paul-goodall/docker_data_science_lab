#!/usr/bin/env bash

docker container stop data_science_lab
docker container prune -f
#bash goodsy_dockerbuild_part12.sh
bash goodsy_dockerbuild_icing.sh
