#!/usr/bin/env bash

docker container stop data_science_lab
docker container prune -f
docker tag goodsy/ddsl_cake:latest goodsy/ddsl_cake:backup
docker tag goodsy/ddsl_cake:latest goodsy/ddsl_cake:testing
bash goodsy_dockerbuild_icing_testing.sh
