#!/bin/bash

set -e

# Get the Powerhouse editor tools:
apt-get update
DEBIAN_FRONTEND=noninteractive
PERL_MM_USE_DEFAULT=1
# ===========================

#cpan PDL
apt-get install -y pdl --install-recommends --install-suggests --install-enhances

# ===========================
# Old version: Minimal Install PDL with PGPLOT and OpenGL for 3D:
#apt-get install -y build-essential libzmq3-dev pgplot5 libpgplot-perl libopengl-perl freeglut3-dev cpanminus pdl
# ===========================
# Istall the iPerl kernel for Jupyter:
cpanm --notest Devel::IPerl

# ===========================
# Not sure what these ones are for:
#apt-get install -y libxi-dev libxmu-dev  libnetpbm10-dev libterm-readline-perl-perl
# ===========================
