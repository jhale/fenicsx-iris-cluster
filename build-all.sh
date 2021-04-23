#!/bin/bash
set -e

source env-build-fenics.sh

./build-cmake.sh
./build-boost.sh
./build-petsc.sh
./build-pybind11.sh
./build-python-modules.sh
./build-fenics.sh
./build-spindle.sh
