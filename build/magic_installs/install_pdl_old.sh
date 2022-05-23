#!/bin/bash

set -e

# Get the Powerhouse editor tools:
apt-get update
DEBIAN_FRONTEND=noninteractive

# ===========================
# Install PDL with PGPLOT and OpenGL for 3D:
apt-get install -y build-essential libzmq3-dev pgplot5 libpgplot-perl libopengl-perl freeglut3-dev cpanminus pdl
PERL_MM_USE_DEFAULT=1
cpanm --notest PDL
cpanm --notest Devel::IPerl

# Important PDL libraries:
cpanm PDL::IO::HDF5
cpanm Astro::Time
cpanm Parallel::Simple
cpanm Term::ProgressBar
cpanm -v PDL::Graphics::Simple --notest
cpan Warnings
cpan Astro::FITS::Header

# Attempts to upgrade PDL but still no demo3d...
apt-get update
DEBIAN_FRONTEND=noninteractive

apt-get install -y libxi-dev libxmu-dev freeglut3-dev libgsl0-dev libnetpbm10-dev libplplot-dev pgplot5 libterm-readline-perl-perl

PERL_MM_USE_DEFAULT=1

(echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan
cpan CPAN

apt-get install -y gcc make
apt-get install -y libpgplot-perl
apt-get install -y libplplot-dev
apt-get install -y libdevel-repl-perl
cpan Devel::REPL
apt-get install -y libproj-dev
apt-get install -y gfortran libextutils-f77-perl
apt-get install -y netpbm
apt-get install -y libgd-dev
apt-get install -y libgsl0-dev
apt-get install -y fftw-dev
apt-get install -y libhdf4-dev
cpan PDL

cpanm PDL::IO::HDF5
cpanm Astro::Time
cpanm Parallel::Simple
cpanm Term::ProgressBar
cpanm -v PDL::Graphics::Simple --notest
cpan warnings
cpanm --notest Astro::FITS::Header
cpan ExtUtils::F77
cpanm --force Astro::FITS::CFITSIO
cpan PGPLOT
cpan PDL::FFTW3
cpan PDL::Graphics::Gnuplot
# ===========================
