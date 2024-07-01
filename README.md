# fenicsx-iris-cluster #
### Scripts to build FEniCSx on the University of Luxembourg iris and aion clusters ###

## Warning

These scripts no longer work because the uni.lu provided compiler
(GCC 10.2.0) cannot compile the latest C++ featurs used in DOLFINx.
Please use Spack and the provided notes
[here](https://gist.github.com/jhale/23d4d7646e2dc05d0adc0395767d044a).

## Introduction

These scripts will automatically build the latest development version of
[FEniCSx](http://fenicsproject.org) with PETSc and HDF5 support on the
University of Luxembourg iris and aion clusters.
 
To build you need to have an account on and be familiar with using the
University of Luxembourg HPC first, see [HPC uni.lu](http://hpc.uni.lu)

## Compiling instructions ##

First clone this repository:
```
cd ~
git clone https://github.com/jhale/fenicsx-iris-cluster.git
cd fenicsx-iris-cluster
```

Adjust the `TAG` and `FLAGS` in `./fenicsx-iris-cluster/env-build-fenics.sh`
appropriately and then build FEniCSx:
```
sbatch build-all.sh
```

FEniCS jobs can be run in interactive mode using e.g.:
```
si # Start interactive session
source ${HOME}/fenicsx-<TAG>/bin/env-fenics.sh # <TAG> should be adjusted as appropriate.
srun python3 script_name.py
```

## Warnings ##

aion and iris have different OS and architecture so be careful with the FFCx
cache and the `FLAGS` variable in `env-build-fenics.sh`.

## Running FEniCS MPI jobs

Included in this repository is a very simple example launcher script to submit
jobs on the cluster.

```
$ cd $HOME
$ cd fenicsx-iris-cluster
$ sbatch -n 4 fenics-launcher.sh python3 poisson.py
```

## Additional notes

- The `PREFIX` environment variable should point to a folder on `${SCRATCH}`.
- The FEniCS JIT cache should also be placed on `${SCRATCH}` by creating a file
  `~/.config/dolfinx/dolfinx_jit_parameters.json` containing:
     
     ```
     {"cache_dir": "/scratch/users/jhale/fenicsx_cache"}     
     ```

- It is worth experimenting with the JIT C compiler flags particularly for
  higher-order polynomial kernels, e.g. for aion `-march=znver2 -O3`.

## Experimental: LLNL Spindle Support

For large parallel jobs the time taken to load the shared object files from the
cluster can dominate the overall runtime. By default we install the [Spindle
tool](https://github.com/hpc/Spindle/) which seems to effectively deal with
this issue on iris.

If you have issues then please remove the `spindle` prefix to `srun` in the
`fenicsx-launcher.sh` script.
