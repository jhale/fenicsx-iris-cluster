#!/bin/bash -l
set -e
source env-build-fenics.sh

VERSION="3.25.3"

mkdir -p $BUILD_DIR

RUN git clone -b gmsh_${GMSH_VERSION} --single-branch --depth 1 https://gitlab.onelab.info/gmsh/gmsh.git && \
    cmake -G Ninja -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_BUILD_TYPE=Release -DENABLE_BUILD_DYNAMIC=1  -DENABLE_OPENMP=1 -B build-dir -S gmsh && \
    cmake --build build-dir && \
    cmake --install build-dir && \
    rm -rf /tmp/*
