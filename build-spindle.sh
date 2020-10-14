#!/bin/bash
set -e
source env-build-fenics.sh

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
    git clone https://github.com/hpc/Spindle.git && \
    cd Spindle && \
    ./bootstrap.sh && \
    ./configure --with-rm=slurm --with-localstorage=/tmp --prefix=${PREFIX} --enable-sec-munge --enable-testsuite=no && \
    make && \
    make install
