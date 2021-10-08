#!/bin/bash
set -e
source env-build-fenics.sh

PYBIND11_VERSION="2.8.0"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
wget --read-timeout=10 -nc https://github.com/pybind/pybind11/archive/v${PYBIND11_VERSION}.tar.gz -O pybind11.tar.gz && \
   mkdir -p ${BUILD_DIR}/pybind11 && \
   tar -xf pybind11.tar.gz -C ${BUILD_DIR}/pybind11 --strip-components=1 && \
   cd pybind11 && \
   mkdir -p build && \
   cd build && \
   cmake -DPYBIND11_TEST=False -DCMAKE_INSTALL_PREFIX=${PREFIX} ../ && \
   make && \
   make install
