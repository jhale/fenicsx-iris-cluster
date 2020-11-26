#!/bin/bash -l
#SBATCH --time=0-00:03:00
source $HOME/fenicsx-iris-cluster/env-fenics.sh
cd $SLURM_SUBMIT_DIR
srun --mpi=pmi2 "$@"
#spindle srun --mpi=pmi2 "$@" 
