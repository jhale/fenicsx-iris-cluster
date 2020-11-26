#!/bin/bash
srun -p interactive -C broadwell --time=02:00:00 -N 1 -n 1 --pty bash -i
