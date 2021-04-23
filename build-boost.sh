#!/bin/bash
set -e
source env-build-fenics.sh

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --read-timeout=10 -nc https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.bz2 -O boost.tar.gz && \
   mkdir -p ${BUILD_DIR}/boost && \
   tar -xf boost.tar.gz -C ${BUILD_DIR}/boost --strip-components=1 && \
   cd boost && \
   ./bootstrap.sh --prefix=$PREFIX
   ./b2 -j 8 --with-timer --with-filesystem --with-program_options cxxflags="-fPIC -std=c++11" toolset="gcc-8.3.0" install
