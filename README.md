# fenicsx-iris-cluster #
### Scripts to build FEniCSX on the University of Luxembourg iris and aion clusters ###

These scripts will automatically build the latest development version of
[FEniCSX](http://fenicsproject.org) with PETSc and HDF5 support on the
University of Luxembourg iris and aion clusters.
 
To build you need to have an account on and be familiar with using [software modules](https://hpc-docs.uni.lu/environment/modules/) the
University of Luxembourg HPC first, see [HPC uni.lu Technical documentation](https://hpc-docs.uni.lu/getting-started/)

## Compiling instructions ##

First clone this repository:
```
cd ~
git clone https://github.com/jhale/fenicsx-iris-cluster.git
cd fenicsx-iris-cluster
```

Adjust the `TAG` and `FLAGS` in `./fenicsx-iris-cluster/env-build-fenics.sh` appropriately and
then build FEniCSx:
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

aion and iris have different OS and architecture so be careful with the FFCx cache.

## Running FEniCS MPI jobs ##

Included in this repository is a very simple example launcher script to submit
jobs on the cluster.

```
$ cd $HOME
$ cd fenicsx-iris-cluster
$ sbatch -n 4 fenics-launcher.sh python3 poisson.py
```

## Experimental: LLNL Spindle Support

For large parallel jobs the time taken to load the shared object files from the
cluster can dominate the overall runtime. By default we install the [Spindle
tool](https://github.com/hpc/Spindle/) which seems to effectively deal with
this issue on iris.

If you have issues then please remove the `spindle` prefix to `srun` in the
`fenicsx-launcher.sh` script.
