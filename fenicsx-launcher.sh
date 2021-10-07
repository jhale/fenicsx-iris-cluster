#!/bin/bash -l
#SBATCH --time=0-00:03:00
#SBATCH -p batch
source $HOME/fenicsx-master-r12/env-fenics.sh
cd $SLURM_SUBMIT_DIR
echo $@
srun "$@"
