#!/bin/bash -l
#SBATCH --time=0-02:00:00
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 8
set -e

source env-build-fenics.sh

./build-petsc.sh
./build-pybind11.sh
./build-python-modules.sh
./build-fenics.sh

cp env-build-fenics.sh ${PREFIX}/bin/env-build-fenics.sh
cp env-fenics.sh ${PREFIX}/bin/env-fenics.sh
