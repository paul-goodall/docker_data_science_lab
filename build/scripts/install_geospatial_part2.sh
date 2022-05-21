#!/bin/bash
set -e

# always set this for scripts but don't declare as ENV..
export DEBIAN_FRONTEND=noninteractive

## build ARGs
NCPUS=${NCPUS:--1}

apt-get update
## Somehow foreign is messed up on CRAN between 2020-04-25 -- 2020-05-0?
##install2.r --error --skipinstalled --repo https://mran.microsoft.com/snapshot/2020-04-24 -n $NCPUS foreign

install2.r --error --skipinstalled -n "$NCPUS" \
    xts \
    gstat \
    spacetime

R -e "remotes::install_version('RandomFields', '3.3')"
R -e "remotes::install_version('geoR', '1.7-5.2.2')"


  install2.r --error --skipinstalled -n "$NCPUS" \
      geosphere \
      BiocManager

#R -e "BiocManager::install('rhdf5')"
R -e "remotes::install_github('grimbough/rhdf5')"

## install wgrib2 for NOAA's NOMADS / rNOMADS forecast files
/rocker_scripts/install_wgrib2.sh

# Clean up
rm -rf /var/lib/apt/lists/*
rm -r /tmp/downloaded_packages
