#!/bin/bash -l
set -e
source env-build-fenics.sh

VERSION="3.25.3"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --no-check-certificate --read-timeout=10 -nc https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}.tar.gz -O cmake.tar.gz && \
   mkdir -p ${BUILD_DIR}/cmake && \
   tar -xf cmake.tar.gz -C ${BUILD_DIR}/cmake --strip-components=1 && \
   cd cmake && \
   cmake -G Ninja -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_BUILD_TYPE="Release" -B build-dir -S . && \
   cmake --build build-dir && \
   cmake --install build-dir
