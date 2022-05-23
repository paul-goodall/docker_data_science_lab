#!/bin/bash

set -e

# Get the Powerhouse editor tools:
apt-get update
DEBIAN_FRONTEND=noninteractive
PERL_MM_USE_DEFAULT=1
# ===========================
# Before anything else, let's configure CPAN and update it:
(echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan
cpan CPAN
# ===========================
# A few prerequisites to enable OpenGL and 3D plotting:
apt-get install -y  build-essential \
                    libzmq3-dev \
                    pgplot5 \
                    libopengl-perl \
                    freeglut3-dev \
                    cpanminus

# Installing exactly as per the PerlDL webpage for "latest possible install on Ubuntu"
apt-get install -y  libpgplot-perl \
                    libplplot-dev \
                    libdevel-repl-perl

cpan Devel::REPL

apt-get install -y  libproj-dev \
                    gfortran \
                    libextutils-f77-perl \
                    netpbm \
                    libgd-dev \
                    libgsl0-dev \
                    fftw-dev \
                    libhdf4-dev

# Above replacements:
# libgd2-xpm-dev ==> libgd-dev
