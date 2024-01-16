#!/bin/bash -l
set -e
source env-build-fenics.sh

VERSION="2.9.2"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --no-check-certificate --read-timeout=10 -nc https://github.com/ornladios/ADIOS2/archive/refs/tags/v${VERSION}.tar.gz -O adios2.tar.gz && \
   mkdir -p ${BUILD_DIR}/adios2 && \
   tar -xf adios2.tar.gz -C ${BUILD_DIR}/adios2 --strip-components=1 && \
   cd adios2 && \
   cmake -G Ninja -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_BUILD_TYPE="Release" -B build-dir -S . && \
   cmake --build build-dir && \
   cmake --install build-dir
