#!/usr/bin/env bash

dockerfile_dir="incremental_dockerfiles"
build_label="ubuntu20_r420_202205"

docker build -f "${dockerfile_dir}/Cake_Dockerfile"  -t "ddsl_cake:${build_label}" .;
docker build -f "${dockerfile_dir}/Icing_Dockerfile" -t "docker_data_science_lab:${build_label}" .;
