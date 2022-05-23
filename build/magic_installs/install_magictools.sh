#!/bin/bash

set -e

# Get the Powerhouse editor tools:
apt-get update
DEBIAN_FRONTEND=noninteractive
# X11
apt-get install -y xauth x11-xserver-utils x11-apps
# Screen manager
apt-get install -y screen
## dplyr database backends
#install2.r --error --skipmissing --skipinstalled -n "$NCPUS" \
#    IRkernel

# Update the Latex install:
tlmgr install scheme-full
tlmgr update --self --all

# =====================
# Install things not available on the package manager:
# Install Jupyter Notebooks:
pip3 install jupyter

# Add R-kernel to Jupyter notebook:
install2.r --error --skipinstalled IRkernel
sudo su - -c "R -e \"IRkernel::installspec(user = FALSE)\""

pip3 install octave_kernel
pip3 install bash_kernel

# Install the latest version of Ghostscript
cd /magic_installs
cat ghostscript-9.56.1.tar.gz.part* > ghostscript-9.56.1.tar.gz
gunzip ghostscript-9.56.1.tar.gz
tar -xvf ghostscript-9.56.1.tar
cd ghostscript-9.56.1
./configure
make
make install

# Install GLE:
cp -rf /magic_installs/gle-4.3.3-Linux/* /usr/.

# Install Imagemagick:
apt-get -y install imagemagick

# Install FFmpeg:
apt-get -y install ffmpeg

# Install light emacs just in case:
apt-get -y install emacs-nox

# ssh setup
apt-get install -y openssh-server
mkdir /var/run/sshd
sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -ri 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config



# ===========================


# =====================
# Clean up the temporary stuff:
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages
rm -rf /magic_installs
# =====================
