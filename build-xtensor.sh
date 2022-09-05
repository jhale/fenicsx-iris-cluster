#!/bin/bash -l
set -e
source env-build-fenics.sh

XTL_VERSION="0.7.4"
XTENSOR_VERSION="0.24.3"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --no-check-certificate --read-timeout=10 -nc https://github.com/xtensor-stack/xtl/archive/refs/tags/${XTL_VERSION}.tar.gz -O xtl.tar.gz && \
   mkdir -p ${BUILD_DIR}/xtl && \
   tar -xf xtl.tar.gz -C ${BUILD_DIR}/xtl --strip-components=1 && \
   cd xtl && \
   cmake -G Ninja -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -B build-dir -S . && \
   cmake --build build-dir && \
   cmake --install build-dir

cd ${BUILD_DIR} && \
   wget --no-check-certificate --read-timeout=10 -nc https://github.com/xtensor-stack/xtensor/archive/refs/tags/${XTENSOR_VERSION}.tar.gz -O xtensor.tar.gz && \
   mkdir -p ${BUILD_DIR}/xtensor && \
   tar -xf xtensor.tar.gz -C ${BUILD_DIR}/xtensor --strip-components=1 && \
   cd xtensor && \
   cmake -G Ninja -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -B build-dir -S . && \
   cmake --build build-dir && \
   cmake --install build-dir
