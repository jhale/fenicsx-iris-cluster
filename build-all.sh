#!/bin/bash -l
#SBATCH --time=0-02:00:00
#SBATCH -p batch
#SBATCH -C broadwell
#SBATCH -N 1
#SBATCH -n 8
set -e

source env-build-fenics.sh

./build-cmake.sh
./build-boost.sh
./build-petsc.sh
./build-pybind11.sh
./build-python-modules.sh
./build-fenics.sh
./build-spindle.sh
