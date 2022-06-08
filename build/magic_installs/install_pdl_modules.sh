#!/bin/bash

set -e

# Get the Powerhouse editor tools:
apt-get update
DEBIAN_FRONTEND=noninteractive
PERL_MM_USE_DEFAULT=1
# ===========================
# ===========================
# Important PDL libraries:
cpan App::cpanminus

cpanm PDL::IO::HDF5
cpanm Astro::Time
cpanm Parallel::Simple
cpanm Term::ProgressBar
cpanm -v PDL::Graphics::Simple --notest
cpan Warnings
cpan warnings
cpanm --notest Astro::FITS::Header
cpan ExtUtils::F77
#cpanm --force Astro::FITS::CFITSIO
cpan PGPLOT
#cpan PDL::FFTW3
#cpanm PDL::Graphics::Gnuplot
# ===========================
