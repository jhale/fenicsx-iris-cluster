#!/bin/bash -l
set -e
source env-build-fenics.sh

VERSION="1.12"

mkdir -p $BUILD_DIR

cd ${BUILD_DIR} && \
   wget --no-check-certificate --read-timeout=10 -nc http://github.com/zeux/pugixml/releases/download/v${VERSION}/pugixml-${VERSION}.tar.gz -O pugixml.tar.gz && \
   mkdir -p ${BUILD_DIR}/pugixml && \
   tar -xf pugixml.tar.gz -C ${BUILD_DIR}/pugixml --strip-components=1 && \
   cd pugixml && \
   cmake -G Ninja -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="${FLAGS}" \
     -DCMAKE_INSTALL_PREFIX=${PREFIX} \
     -DPUGIXML_BUILD_SHARED_AND_STATIC_LIBS=OFF \
     -DBUILD_SHARED_LIBS=ON \
     -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
     -B build-dir -S . && \
   cmake --build build-dir && \
   cmake --install build-dir
