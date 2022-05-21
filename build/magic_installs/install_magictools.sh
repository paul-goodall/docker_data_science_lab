#!/bin/bash

set -e

# Get the Powerhouse editor tools:
apt-get update
# X11
apt-get install -y xauth x11-xserver-utils x11-apps
# Screen manager
apt-get install -y screen
## dplyr database backends
#install2.r --error --skipmissing --skipinstalled -n "$NCPUS" \
#    IRkernel

# =====================
# Install things not available on the package manager:
# Install Jupyter Notebooks:
pip3 install jupyter

# Add R-kernel to Jupyter notebook:
install2.r --error --skipinstalled IRkernel
sudo su - -c "R -e \"IRkernel::installspec(user = FALSE)\""

# Install the latest version of Ghostscript
cd /magic_installs
gunzip ghostscript-9.56.1.tar.gz
tar -xvf ghostscript-9.56.1.tar
cd ghostscript-9.56.1
./configure
make
make install

# Install GLE:
cp -rf /magic_installs/gle-4.3.3-Linux/* /usr/.

# Install PDL with PGPLOT and OpenGL for 3D:
apt-get install -y build-essential pgplot5 libpgplot-perl libopengl-perl freeglut3-dev pdl

# Install Imagemagick:
apt-get -y install imagemagick

# Install FFmpeg:
apt-get -y install ffmpeg

# Install light emacs just in case:
apt-get -y install emacs-nox

# =====================
# Clean up the temporary stuff:
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages
rm -rf /magic_installs
# =====================
