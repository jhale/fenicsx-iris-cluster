#!/bin/bash
set -e

source env-build-fenics.sh
mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --read-timeout=10 -nc https://github.com/Kitware/CMake/releases/download/v3.19.3/cmake-3.19.3.tar.gz -O cmake.tar.gz && \
   mkdir -p ${BUILD_DIR}/cmake && \
   tar -xf cmake.tar.gz -C ${BUILD_DIR}/cmake --strip-components=1 && \
   cd cmake && \
   mkdir build && \
   cd build && \
   cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_USE_OPENSSL=OFF ../ && \
   make -j8 install
