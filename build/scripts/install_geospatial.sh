#!/bin/bash
set -e

# always set this for scripts but don't declare as ENV..
export DEBIAN_FRONTEND=noninteractive


# =====================
# PTG additions:
apt update -qq
# install two helper packages we need
apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
apt-get update && sudo apt-get upgrade
# =====================

## build ARGs
NCPUS=${NCPUS:--1}

apt-get update
apt-get install -y --no-install-recommends \
    gdal-bin \
    lbzip2 \
    libfftw3-dev \
    libgdal-dev \
    libgeos-dev \
    libgsl0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libhdf5-dev \
    libjq-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libnetcdf-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev \
    lsb-release \
    netcdf-bin \
    postgis \
    protobuf-compiler \
    sqlite3 \
    tk-dev \
    unixodbc-dev

# lwgeom 0.2-2 and 0.2-3 have a regression which prevents install on ubuntu:bionic
## permissionless PAT for builds
UBUNTU_VERSION=$(lsb_release -sc)
if [ "${UBUNTU_VERSION}" == "bionic" ]; then
    R -e "remotes::install_version('lwgeom', '0.2-4')"
fi

## Somehow foreign is messed up on CRAN between 2020-04-25 -- 2020-05-0?
##install2.r --error --skipinstalled --repo https://mran.microsoft.com/snapshot/2020-04-24 -n $NCPUS foreign

install2.r --error --skipinstalled -n "$NCPUS" \
    RColorBrewer \
    xts \
    gstat \
    spacetime



R -e "remotes::install_version('RandomFields', '3.3')"

  install2.r --error --skipinstalled -n "$NCPUS" \
      RColorBrewer \
      RandomFields \
      RNetCDF \
      classInt \
      deldir \
      hdf5r \
      lidR \
      mapdata \
      maptools \
      mapview \
      ncdf4 \
      proj4 \
      raster \
      rgdal \
      rgeos \
      rlas \
      sf \
      sp \
      spatstat \
      spatialreg \
      spdep \
      stars \
      terra \
      tidync \
      tmap

R -e "remotes::install_version('geoR', '1.8-1')"


  install2.r --error --skipinstalled -n "$NCPUS" \
      geosphere \
      BiocManager

R -e "BiocManager::install('rhdf5')"

## install wgrib2 for NOAA's NOMADS / rNOMADS forecast files
/rocker_scripts/install_wgrib2.sh

# Clean up
rm -rf /var/lib/apt/lists/*
rm -r /tmp/downloaded_packages
