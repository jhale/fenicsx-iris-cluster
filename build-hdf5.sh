#!/bin/bash -l
set -e
source env-build-fenics.sh

mkdir -p $BUILD_DIR

export HDF5_SERIES=1.12
export HDF5_PATCH=1

cd ${BUILD_DIR} && \
    wget -nc --quiet https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${HDF5_SERIES}/hdf5-${HDF5_SERIES}.${HDF5_PATCH}/src/hdf5-${HDF5_SERIES}.${HDF5_PATCH}.tar.gz -O hdf5.tar.gz && \
    mkdir -p ${BUILD_DIR}/hdf5 && \
    tar -xf hdf5.tar.gz -C ${BUILD_DIR}/hdf5 --strip-components=1 && \
    cd hdf5 && \
    ./configure --prefix=${PREFIX} --enable-parallel --enable-shared --enable-static=no && \
    make -j16 install
 
