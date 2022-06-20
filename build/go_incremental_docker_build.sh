#!/usr/bin/env bash

DfDir="incremental_dockerfiles"

i1=17
i2=17

for (( i=$i1; i<=$i2; i++ ));
do
  printf -v ii "%02d" $i

  dockerfile_name="${DfDir}/Dockerfile${ii}"
  image_name="ddsl_part${ii}"
  docker_stamp="Dockerfile_$(date +%Y.%m.%d-%H.%M.%S)"
  my_com="docker build -f $dockerfile_name --build-arg docker_stamp=$docker_stamp --build-arg docker_file=$dockerfile_name -t $image_name ."
  echo "$my_com"
  ${my_com}

done

printf -v ii "%02d" $i2
image_name="ddsl_part${ii}:latest"
docker tag $image_name goodsy/ddsl_cake:latest
